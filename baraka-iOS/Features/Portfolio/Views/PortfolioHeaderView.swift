//
//  PortfolioHeaderView.swift
//  baraka-iOS
//
//  Created by Muhammad Waqas on 26/06/2025.
//
/// Header view displaying balance info and language toggle.
import UIKit

class PortfolioHeaderView: UIView {

    let netValueLabel = UILabel()
    let netValueTextLabel = UILabel()
    let languageButton = UIButton(type: .system)
    let pnlPercentageLabel = UILabel()
    let pnlPercentageTextLabel = UILabel()
    private let topStack = UIStackView()
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let balanceStack = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }

    private func setupLayout() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.borderColor = UIColor.separator.cgColor
        layer.borderWidth = 0.5
        translatesAutoresizingMaskIntoConstraints = false

        profileImageView.image = UIImage(systemName: "person.circle")
        profileImageView.tintColor = .label
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true

        nameLabel.font = Theme.Fonts.title
        nameLabel.text = "John Doe"

        languageButton.setTitleColor(.white, for: .normal)
        languageButton.backgroundColor = Theme.Colors.accent
        languageButton.layer.cornerRadius = 8

        topStack.axis = .horizontal
        topStack.alignment = .center
        topStack.distribution = .equalCentering
        topStack.spacing = 8
        topStack.translatesAutoresizingMaskIntoConstraints = false
        topStack.addArrangedSubview(profileImageView)
        topStack.addArrangedSubview(nameLabel)
        topStack.addArrangedSubview(languageButton)

        balanceStack.axis = .horizontal
        balanceStack.distribution = .fillEqually
        balanceStack.spacing = 8
        balanceStack.translatesAutoresizingMaskIntoConstraints = false

        let leftBalanceStack = UIStackView(arrangedSubviews: [netValueLabel, netValueTextLabel])
        leftBalanceStack.axis = .vertical
        leftBalanceStack.alignment = .center
        leftBalanceStack.spacing = 4

        let rightBalanceStack = UIStackView(arrangedSubviews: [pnlPercentageLabel, pnlPercentageTextLabel])
        rightBalanceStack.axis = .vertical
        rightBalanceStack.alignment = .center
        rightBalanceStack.spacing = 4

        balanceStack.addArrangedSubview(leftBalanceStack)
        balanceStack.addArrangedSubview(rightBalanceStack)

        netValueLabel.font = Theme.Fonts.largeTitle
        netValueTextLabel.font = Theme.Fonts.title
        pnlPercentageLabel.font = Theme.Fonts.largeTitle
        pnlPercentageTextLabel.font = Theme.Fonts.title

        addSubview(topStack)
        addSubview(balanceStack)

        NSLayoutConstraint.activate([
            topStack.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            topStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            topStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            balanceStack.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 12),
            balanceStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            balanceStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            balanceStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            balanceStack.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}
