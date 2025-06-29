//
//  NetworkEngine.swift
//  baraka-iOS
//
//  Created by Muhammad Waqas on 26/06/2025.
//
/// Executes API requests using URLSession.
//
import Foundation
import RxSwift

/// Describes the capabilities required for executing API requests.
protocol NetworkEngineProtocol {
    func execute<Request: APIRequest>(_ request: Request) -> Single<Request.Response>
}

/// Default implementation of `NetworkEngineProtocol` using `URLSession`.
final class NetworkEngine: NetworkEngineProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func execute<Request: APIRequest>(_ request: Request) -> Single<Request.Response> {
        Single.create { single in
            let task = self.session.dataTask(with: request.urlRequest) { data, response, error in
                if let error = error {
                    single(.failure(error))

                    return
                }

                guard let data = data else {
                    single(.failure(NSError(domain: "NetworkEngine", code: -1, userInfo: nil)))

                    return
                }

                do {
                    let parsed = try request.parse(data)
                    single(.success(parsed))
                } catch {
                    single(.failure(error))
                }
            }
            task.resume()

            return Disposables.create { task.cancel() }
        }
    }
}
