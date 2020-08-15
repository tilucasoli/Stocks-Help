//
//  balance.swift
//  Stocks Help
//
//  Created by Lucas Oliveira on 13/08/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class BalanceView: UIView {
    
    let balance: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        lbl.textColor = UIColor.purpleSH
        lbl.text = "R$ 23.640,00"
        return lbl
    }()
    
    let totalInvested: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        lbl.textColor = UIColor.textColorSH.withAlphaComponent(0.7)
        lbl.text = "Total investido: R$ 21.200,00"
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBalanceLbl()
        setupTotalInvested()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBalanceLbl() {
        addSubview(balance)
        balance.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            balance.leftAnchor.constraint(equalTo: leftAnchor),
            balance.topAnchor.constraint(equalTo: topAnchor),
            balance.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    func setupTotalInvested() {
        addSubview(totalInvested)
        totalInvested.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            totalInvested.topAnchor.constraint(equalTo: balance.bottomAnchor, constant: 4),
            totalInvested.leftAnchor.constraint(equalTo: balance.leftAnchor),
            totalInvested.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
