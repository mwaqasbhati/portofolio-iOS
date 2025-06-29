//
//  MarketPriceService.swift
//  baraka-iOS
//
//  Created by Muhammad Waqas on 26/06/2025.
//
//  Simulates live market prices for instruments.

import Foundation
import RxSwift

protocol MarketPriceServiceProtocol {
    /// Emits updated prices for the provided instruments every second.
    func priceStream(for instruments: [Instrument]) -> Observable<[String: Double]>
}

final class MarketPriceService: MarketPriceServiceProtocol {
    private let scheduler: SchedulerType

    init(scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
        self.scheduler = scheduler
    }

    func priceStream(for instruments: [Instrument]) -> Observable<[String: Double]> {
        let basePrices = instruments.reduce(into: [String: Double]()) { result, instrument in
            result[instrument.ticker] = instrument.lastTradedPrice
        }
        return Observable<Int>.interval(.seconds(1), scheduler: scheduler)
            .map { _ in
                var updates: [String: Double] = [:]
                for instrument in instruments {
                    let base = basePrices[instrument.ticker] ?? instrument.lastTradedPrice
                    let range = base * 0.1
                    let newPrice = base + Double.random(in: -range...range)
                    updates[instrument.ticker] = newPrice
                }
                return updates
            }
            .share(replay: 1, scope: .whileConnected)
    }
}

