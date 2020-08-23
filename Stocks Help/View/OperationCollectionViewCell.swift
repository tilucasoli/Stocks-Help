//
//  OperationCollectionViewCell.swift
//  Stocks Help
//
//  Created by Lucas Oliveira on 17/08/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

enum OperationType {
    case sell, buy
}

class OperationCollectionViewCell: UICollectionViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor.textColorSH
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let coloredView: UIView = {
        let view = UIView(frame: CGRect(x: 32, y: 32, width: 33, height: 33))
        view.layer.cornerRadius = 17
        view.backgroundColor = UIColor.redSH.withAlphaComponent(0.5)
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let icon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupColoredView()
        setupLabel()
        setupIcon()
        layer.cornerRadius = 4
        layer.borderWidth = 2.5
        layer.borderColor = UIColor.textColorSH.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabel() {
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setupColoredView() {
        addSubview(coloredView)
    }
    
    func setupIcon() {
        addSubview(icon)
        
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: topAnchor, constant: 13.5),
            icon.centerXAnchor.constraint(equalTo: centerXAnchor),
            icon.heightAnchor.constraint(equalToConstant: 53),
            icon.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func smallToBig() {
        coloredView.backgroundColor = coloredView.backgroundColor?.withAlphaComponent(0.7)
        
        coloredView.frame = CGRect(x: 5, y: 0, width: 91, height: 91)
        coloredView.layer.cornerRadius = 45
    }
    
    func bigToSmall() {
        coloredView.backgroundColor = coloredView.backgroundColor?.withAlphaComponent(0.3)
        
        coloredView.frame = CGRect(x: 32, y: 32, width: 33, height: 33)
        coloredView.layer.cornerRadius = 17
    }
    
}
