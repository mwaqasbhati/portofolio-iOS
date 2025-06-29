//
//  PortfolioViewModel.swift
//  baraka-iOS
//
//  Created by Muhammad Waqas on 26/06/2025.
//
/// View model responsible for fetching and exposing portfolio data.
//
import Foundation
import RxSwift

enum PortfolioError: Error {
    case network
    case noInternet
    case parsing
    case unknown
}

class PortfolioViewModel {
    private let service: PortfolioServiceProtocol
    private let marketService: MarketPriceServiceProtocol
    private let disposeBag = DisposeBag()
    private var priceSubscription: Disposable?

    private var basePositions: [PositionEntity] = []

    let balance = BehaviorSubject<BalanceEntity?>(value: nil)
    let positions = BehaviorSubject<[PositionEntity]>(value: [])
    let isLoading = BehaviorSubject<Bool>(value: false)
    let error = PublishSubject<PortfolioError>()

    init(service: PortfolioServiceProtocol = PortfolioService(),
         marketService: MarketPriceServiceProtocol = MarketPriceService()) {
        self.service = service
        self.marketService = marketService
    }

    func fetchPortfolio() {
        isLoading.onNext(true)
        service.fetchPortfolio()
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                self.isLoading.onNext(false)
                let dto = PortfolioEntity(from: response.portfolio)
                self.basePositions = dto.positions
                self.balance.onNext(dto.balance)
                self.positions.onNext(dto.positions)
                self.subscribeToPrices(for: dto.positions.map { $0.instrument })
            }, onFailure: { [weak self] error in
                guard let self = self else { return }
                self.isLoading.onNext(false)
                self.error.onNext(self.mapError(error))
            })
            .disposed(by: disposeBag)
    }

    private func mapError(_ error: Error) -> PortfolioError {
        if let urlError = error as? URLError {
            if urlError.code == .notConnectedToInternet {

                return .noInternet
            }

            return .network
        } else if error is DecodingError {

            return .parsing
        }

        return .unknown
    }

    private func subscribeToPrices(for instruments: [InstrumentEntity]) {
        priceSubscription?.dispose()

        priceSubscription = marketService.priceStream(for: instruments.map { $0.model })
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] prices in
                self?.applyPrices(prices)
            })
    }

    deinit {
        priceSubscription?.dispose()
    }
    
    private func applyPrices(_ prices: [String: Double]) {
        let updated = basePositions.map { position -> PositionEntity in
            let ticker = position.instrument.ticker
            let newPrice = prices[ticker] ?? position.instrument.lastTradedPrice
            let instrument = Instrument(
                ticker: ticker,
                name: position.instrument.name,
                exchange: position.instrument.exchange,
                currency: position.instrument.currency,
                lastTradedPrice: newPrice
            )
            let marketValue = position.quantity * newPrice
            let pnl = marketValue - position.cost
            let pnlPercentage = (pnl * 100) / position.cost
            return PositionEntity(from: Position(
                instrument: instrument,
                quantity: position.quantity,
                averagePrice: position.averagePrice,
                cost: position.cost,
                marketValue: marketValue,
                pnl: pnl,
                pnlPercentage: pnlPercentage
            ))
        }

        let netValue = updated.reduce(0) { $0 + $1.marketValue }
        let totalPnl = updated.reduce(0) { $0 + $1.pnl }
        let totalCost = updated.reduce(0) { $0 + $1.cost }
        let balance = BalanceEntity(from: Balance(
            netValue: netValue,
            pnl: totalPnl,
            pnlPercentage: totalCost == 0 ? 0 : (totalPnl * 100) / totalCost
        ))

        self.balance.onNext(balance)
        self.positions.onNext(updated)
    }
}
