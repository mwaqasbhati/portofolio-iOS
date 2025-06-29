import Testing
@testable import baraka_iOS

struct PriceFormatterTests {
    @Test func formatsTwoDecimalPlaces() {
        let formatted = PriceFormatter.format(1234.567)
        #expect(formatted == "1234.57")
    }
}
