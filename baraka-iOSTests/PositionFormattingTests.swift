import Testing
@testable import baraka_iOS

struct PositionFormattingTests {
    @Test func computesDisplays() {
        let instrument = Instrument(ticker: "AAPL", name: "Apple", exchange: "NASDAQ", currency: "$", lastTradedPrice: 10)
        let position = PositionEntity(from: Position(instrument: instrument, quantity: 2, averagePrice: 8, cost: 16, marketValue: 20, pnl: 4, pnlPercentage: 25))
        #expect(position.isProfit)
        #expect(position.lastPriceDisplay == "$ 10.00")
        #expect(position.quantityCostDisplay == "2.0 x 8.00 = 16.00")
        #expect(position.marketValueDisplay == "20.00")
        #expect(position.pnlDisplay == "4.00 (+25%)")
    }
}
