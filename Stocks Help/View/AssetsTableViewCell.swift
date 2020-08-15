//
//  AssetsTableViewCell.swift
//  Stocks Help
//
//  Created by Lucas Oliveira on 15/08/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class AssetsTableViewCell: UITableViewCell {
    
    let contentWhiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        return view
    }()
    
    let companyLogo: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "azul logo")
        imgView.backgroundColor = .white
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    let stockCode: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        lbl.textColor = UIColor.textColorSH.withAlphaComponent(0.85)
        return lbl
    }()
    
    let stockQuote: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        lbl.textColor = UIColor.textColorSH
        return lbl
    }()
    
    let stockQuotePercentage: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        lbl.textColor = UIColor.greenSH
        return lbl
    }()
    
    let totalBalance: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        lbl.textColor = UIColor.textColorSH
        return lbl
    }()
    
    let totalInvested: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        lbl.textColor = UIColor.textColorSH.withAlphaComponent(0.7)
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .backgroundSH
        setupContentWhiteView()
        setupCompanyLogo()
        setupStockCode()
        setupStockQuote()
        setupStockQuotePercentage()
        setupTotalBalance()
        setupTotalInvested()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContentWhiteView() {
        addSubview(contentWhiteView)
        contentWhiteView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentWhiteView.topAnchor.constraint(equalTo: topAnchor),
            contentWhiteView.leftAnchor.constraint(equalTo: leftAnchor),
            contentWhiteView.rightAnchor.constraint(equalTo: rightAnchor),
            contentWhiteView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    func setupCompanyLogo() {
        addSubview(companyLogo)
        companyLogo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            companyLogo.centerYAnchor.constraint(equalTo: contentWhiteView.centerYAnchor),
            companyLogo.leftAnchor.constraint(equalTo: contentWhiteView.leftAnchor, constant: 8),
            companyLogo.widthAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    func setupStockCode() {
        addSubview(stockCode)
        stockCode.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stockCode.leftAnchor.constraint(equalTo: companyLogo.rightAnchor, constant: 12),
            stockCode.centerYAnchor.constraint(equalTo: contentWhiteView.centerYAnchor)
        ])
    }
    
    func setupStockQuote() {
        addSubview(stockQuote)
        stockQuote.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stockQuote.leftAnchor.constraint(equalTo: stockCode.rightAnchor, constant: 26),
            stockQuote.topAnchor.constraint(equalTo: contentWhiteView.topAnchor, constant: 12)
        ])
    }
    
    func setupStockQuotePercentage() {
        addSubview(stockQuotePercentage)
        stockQuotePercentage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stockQuotePercentage.centerXAnchor.constraint(equalTo: stockQuote.centerXAnchor),
            stockQuotePercentage.topAnchor.constraint(equalTo: stockQuote.bottomAnchor, constant: 4)
        ])
    }
    
    func setupTotalBalance() {
        addSubview(totalBalance)
        totalBalance.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            totalBalance.leftAnchor.constraint(equalTo: stockQuote.rightAnchor, constant: 32),
            totalBalance.centerYAnchor.constraint(equalTo: stockQuote.centerYAnchor)
        ])
    }
    
    func setupTotalInvested() {
        addSubview(totalInvested)
        totalInvested.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            totalInvested.centerXAnchor.constraint(equalTo: totalBalance.centerXAnchor),
            totalInvested.topAnchor.constraint(equalTo: totalBalance.bottomAnchor, constant: 4)
        ])
    }
    
}
