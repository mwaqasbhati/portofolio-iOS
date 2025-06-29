//
//  APIRequest.swift
//  baraka-iOS
//
//  Created by Muhammad Waqas on 26/06/2025.
//
/// Defines the APIRequest protocol and supporting types.
//
import Foundation

/// HTTP method for a request.
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

/// Represents an API endpoint that can construct a URL request and parse its response.
protocol APIRequest {
    associatedtype Response: Decodable
    /// Base URL for the request.
    var baseURL: URL { get }
    /// Path component appended to the base URL.
    var path: String { get }
    /// HTTP method to use when performing the request.
    var method: HTTPMethod { get }
    /// Optional HTTP headers.
    var headers: [String: String]? { get }
    /// Optional request body.
    var body: Data? { get }

    /// Constructed `URLRequest` using the provided components.
    var urlRequest: URLRequest { get }

    func parse(_ data: Data) throws -> Response
}

extension APIRequest {
    var method: HTTPMethod { .get }
    var headers: [String: String]? { nil }
    var body: Data? { nil }

    var urlRequest: URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        return request
    }

    /// Default parsing implementation using `JSONDecoder`.
    func parse(_ data: Data) throws -> Response {
        try JSONDecoder().decode(Response.self, from: data)
    }
}
