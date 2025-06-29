//
//  PortfolioService.swift
//  baraka-iOS
//
//  Created by Muhammad Waqas on 26/06/2025.
//
/// Service layer for portfolio network operations.
//
import Foundation
import RxSwift

protocol PortfolioServiceProtocol {
    func fetchPortfolio() -> Single<PortfolioResponse>
}

class PortfolioService: PortfolioServiceProtocol {
    private let environment: Environment
    private let network: NetworkEngineProtocol

    init(environment: Environment = .current,
         network: NetworkEngineProtocol = NetworkEngine()) {
        self.environment = environment
        self.network = network
    }

    func fetchPortfolio() -> Single<PortfolioResponse> {
        let request = PortfolioRequest(baseURL: environment.baseURL)
        return network.execute(request)
    }
}
