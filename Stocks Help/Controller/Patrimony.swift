//
//  ViewController.swift
//  Stocks Help
//
//  Created by Lucas Oliveira on 13/08/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class Patrimony: UIViewController, Background {
    
    let balanceView = BalanceView()
    let pieChartCustom = ChartView()
    
    let assetsLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Meus Ativos"
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        lbl.textColor = UIColor.textColorSH
        return lbl
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        
        tableView.register(AssetsTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 58 + 8
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageBackground()
        setupLargeTitle()
        setupNavControllerButton()
        setupBalanceView()
        setupPieChartCustom()
        setupAssetsLbl()
        setupTableView()
        view.backgroundColor = .backgroundSH

    }
    
    override func viewWillAppear(_ animated: Bool) {
        ListAssets.refreshCurrentPrice()
        pieChartCustom.updateChartData()
        tableView.reloadData()
        balanceView.updateValues()
    }
    
    func setupLargeTitle() {
        title = "Meu Patrimônio"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textColorSH]
    }
    
    func setupNavControllerButton() {
        let addOperation = UIBarButtonItem(image: UIImage(named: "add"), style: .done, target: self, action: #selector(pushAddOperation))
        navigationItem.rightBarButtonItem = addOperation
        navigationController?.navigationBar.tintColor = .redSH
        
    }
    
    @objc func pushAddOperation() {
        let newOperationVC = NewOperation()
        navigationController?.pushViewController(newOperationVC, animated: true)
    }
    
    func setupBalanceView() {
        view.addSubview(balanceView)
        balanceView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            balanceView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            balanceView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16)
        ])
        
    }
    
    func setupPieChartCustom() {
        view.addSubview(pieChartCustom)
        pieChartCustom.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pieChartCustom.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pieChartCustom.topAnchor.constraint(equalTo: balanceView.bottomAnchor, constant: 32),
            pieChartCustom.heightAnchor.constraint(equalToConstant: 258),
            pieChartCustom.widthAnchor.constraint(equalToConstant: 258)
        ])
        
    }
    
    func setupAssetsLbl() {
        view.addSubview(assetsLbl)
        assetsLbl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            assetsLbl.topAnchor.constraint(equalTo: pieChartCustom.bottomAnchor, constant: 32),
            assetsLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
        ])
        
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: assetsLbl.bottomAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

extension Patrimony: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListAssets.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? AssetsTableViewCell
        
        guard let cellValid = cell else {
            return UITableViewCell()
        }
        
        cellValid.configure(asset: ListAssets.list[indexPath.row])
        
        return cellValid
    }
    
}
