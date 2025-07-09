//
//  ViewController.swift
//  baraka-iOS
//
//  Created by Muhammad Waqas on 26/06/2025.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: createLayout())
    private let headerView = PortfolioHeaderView()
    private let refreshControl = UIRefreshControl()

    private let viewModel = PortfolioViewModel()
    private let disposeBag = DisposeBag()
    private var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        updateLanguage()
        setupActivityIndicator()
        bindViewModel()
        viewModel.fetchPortfolio()
    }

    @objc private func languageButtonPressed(_ sender: Any) {
        Localization.toggleLanguage()
        updateLanguage()
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
        collectionView.reloadData()
    }

    @objc private func refreshData() {
        viewModel.fetchPortfolio()
    }

    private func updateLanguage() {
        UIView.appearance().semanticContentAttribute = Localization.current.semantic
        headerView.netValueTextLabel.text = Localization.netValueText
        headerView.pnlPercentageTextLabel.text = Localization.pnlWithPercentageText
        headerView.languageButton.setTitle(Localization.buttonTitle, for: .normal)
        view.semanticContentAttribute = Localization.current.semantic
        collectionView.semanticContentAttribute = Localization.current.semantic
        SemanticsUtility.updateSemantics(for: view, semantic: Localization.current.semantic)
    }

    private func setupActivityIndicator() {
        activityIndicator = ActivityIndicatorHelper.add(to: view)
    }

    private func bindViewModel() {
        viewModel.balance
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] balance in
                guard let self = self else { return }
                self.headerView.netValueLabel.text = balance.netValueDisplay
                self.headerView.pnlPercentageLabel.attributedText = .coloredPercentageValueOnly(fullText: balance.pnlDisplay, isProfit: balance.isProfit)
                self.headerView.pnlPercentageTextLabel.text = Localization.pnlWithPercentageText
            })
            .disposed(by: disposeBag)

        viewModel.positions
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)

        viewModel.positions
            .bind(to: collectionView.rx.items(cellIdentifier: "PositionCollectionViewCell", cellType: PositionCollectionViewCell.self)) { row, position, cell in
                cell.configure(with: position)
            }
            .disposed(by: disposeBag)

        viewModel.isLoading
            .observe(on: MainScheduler.instance)
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)

        viewModel.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                guard let self = self else { return }
                self.refreshControl.endRefreshing()
                AlertPresenter.present(error: error, from: self)
            })
            .disposed(by: disposeBag)
    }

    private func setupLayout() {
        view.backgroundColor = .systemBackground

        headerView.languageButton.addTarget(self, action: #selector(languageButtonPressed), for: .touchUpInside)
        view.addSubview(headerView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(PositionCollectionViewCell.self, forCellWithReuseIdentifier: "PositionCollectionViewCell")

        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 8

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}


