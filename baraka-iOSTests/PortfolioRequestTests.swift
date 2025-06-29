import Testing
import Foundation
@testable import baraka_iOS

struct PortfolioRequestTests {
    @Test func createsURLRequest() {
        let base = URL(string: "https://example.com")!
        let request = PortfolioRequest(baseURL: base)
        let urlRequest = request.urlRequest
        #expect(urlRequest.httpMethod == HTTPMethod.get.rawValue)
        #expect(urlRequest.url?.absoluteString == "https://example.com/c/60b7-70a6-4ee3-bae8")
    }
}
