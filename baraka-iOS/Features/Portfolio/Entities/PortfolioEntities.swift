import Foundation

/// Non-Codable representations used by the UI.
struct PortfolioEntity {
    let balance: BalanceEntity
    let positions: [PositionEntity]

    init(from portfolio: Portfolio) {
        self.balance = BalanceEntity(from: portfolio.balance)
        self.positions = portfolio.positions.map(PositionEntity.init)
    }
}

struct BalanceEntity {
    let netValue: Double
    let pnl: Double
    let pnlPercentage: Double

    init(from balance: Balance) {
        self.netValue = balance.netValue
        self.pnl = balance.pnl
        self.pnlPercentage = balance.pnlPercentage
    }
}

struct PositionEntity {
    let instrument: InstrumentEntity
    let quantity: Double
    let averagePrice: Double
    let cost: Double
    let marketValue: Double
    let pnl: Double
    let pnlPercentage: Double

    init(from position: Position) {
        self.instrument = InstrumentEntity(from: position.instrument)
        self.quantity = position.quantity
        self.averagePrice = position.averagePrice
        self.cost = position.cost
        self.marketValue = position.marketValue
        self.pnl = position.pnl
        self.pnlPercentage = position.pnlPercentage
    }
}

struct InstrumentEntity {
    let ticker: String
    let name: String
    let exchange: String
    let currency: String
    let lastTradedPrice: Double

    init(from instrument: Instrument) {
        self.ticker = instrument.ticker
        self.name = instrument.name
        self.exchange = instrument.exchange
        self.currency = instrument.currency
        self.lastTradedPrice = instrument.lastTradedPrice
    }

    /// Convert back to the codable model when interacting with services.
    var model: Instrument {
        Instrument(ticker: ticker,
                   name: name,
                   exchange: exchange,
                   currency: currency,
                   lastTradedPrice: lastTradedPrice)
    }
}
