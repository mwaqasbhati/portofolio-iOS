import Testing
@testable import baraka_iOS

struct BalanceFormattingTests {
    @Test func computesProfitProperties() {
        let balance = BalanceEntity(from: Balance(netValue: 100, pnl: 10, pnlPercentage: 10))
        #expect(balance.isProfit)
        #expect(balance.netValueDisplay == "100.00")
        #expect(balance.pnlValueDisplay == "10.00")
        #expect(balance.pnlPercentageDisplay == "(+10%)")
        #expect(balance.pnlDisplay == "10.00 (+10%)")
    }

    @Test func computesLossProperties() {
        let balance = BalanceEntity(from: Balance(netValue: 100, pnl: -5, pnlPercentage: -5))
        #expect(!balance.isProfit)
        #expect(balance.pnlDisplay == "-5.00 (-5%)")
    }
}
