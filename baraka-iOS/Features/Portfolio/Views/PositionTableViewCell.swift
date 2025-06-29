//
//  PositionTableViewCell.swift
//  baraka-iOS
//
//  Created by Muhammad Waqas on 26/06/2025.
//
/// Table view cell displaying a portfolio position.
//
import UIKit

class PositionTableViewCell: UITableViewCell {

    private let tickerLabel = UILabel()
    private let pnlLabel = UILabel()
    private let currencyAndLastPriceLabel = UILabel()
    private let costLabel = UILabel()
    private let nameExchangeLabel = UILabel()
    private let marketValueLabel = UILabel()
    private let mainStack = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }

    private func setupLayout() {
        selectionStyle = .none

        tickerLabel.font = Theme.Fonts.bodyBold
        pnlLabel.font = Theme.Fonts.bodyBold
        currencyAndLastPriceLabel.font = Theme.Fonts.captionBold
        costLabel.font = Theme.Fonts.caption
        nameExchangeLabel.font = Theme.Fonts.caption
        nameExchangeLabel.numberOfLines = 0
        marketValueLabel.font = Theme.Fonts.bodyBold

        let topStack = UIStackView(arrangedSubviews: [tickerLabel, pnlLabel])
        topStack.axis = .horizontal
        topStack.distribution = .equalCentering

        let middleStack = UIStackView(arrangedSubviews: [currencyAndLastPriceLabel, costLabel])
        middleStack.axis = .horizontal
        middleStack.distribution = .equalCentering

        let bottomStack = UIStackView(arrangedSubviews: [nameExchangeLabel, marketValueLabel])
        bottomStack.axis = .horizontal
        bottomStack.distribution = .equalCentering

        mainStack.axis = .vertical
        mainStack.spacing = 8
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(topStack)
        mainStack.addArrangedSubview(middleStack)
        mainStack.addArrangedSubview(bottomStack)

        contentView.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    func configure(with position: PositionEntity) {
        let instrument = position.instrument

        tickerLabel.text = instrument.ticker
        pnlLabel.attributedText = .coloredPercentageValueOnly(
            fullText: position.pnlDisplay,
            isProfit: position.isProfit
        )
        currencyAndLastPriceLabel.text = position.lastPriceDisplay
        costLabel.text = position.quantityCostDisplay
        nameExchangeLabel.text = "\(instrument.name)\n\(instrument.exchange)"
        marketValueLabel.text = position.marketValueDisplay
    }
}
