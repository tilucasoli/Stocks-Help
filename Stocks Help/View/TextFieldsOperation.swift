//
//  textFieldsOperation.swift
//  Stocks Help
//
//  Created by Lucas Oliveira on 17/08/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class TextFieldsOperation: UIView {
    let labelTF: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor.textColorSH
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textField: UITextField = {
        let txtfield = UITextField()
        
        txtfield.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        txtfield.textColor = UIColor.textColorSH.withAlphaComponent(0.7)
        txtfield.backgroundColor = .clear
        txtfield.attributedPlaceholder = NSAttributedString(string: "teste", attributes: [NSAttributedString.Key.foregroundColor: UIColor.textColorSH.withAlphaComponent(0.4)])
        txtfield.underlined()
        
        txtfield.translatesAutoresizingMaskIntoConstraints = false
        return txtfield
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabelTF()
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabelTF() {
        addSubview(labelTF)
        
        NSLayoutConstraint.activate([
            labelTF.topAnchor.constraint(equalTo: topAnchor),
            labelTF.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }
    
    func setupTextField() {
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: labelTF.bottomAnchor, constant: 4),
            textField.rightAnchor.constraint(equalTo: rightAnchor),
            textField.leftAnchor.constraint(equalTo: leftAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}

extension UITextField {
    
    func underlined() {
        self.layer.backgroundColor = UIColor.backgroundSH.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.textColorSH.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 0

    }
}
