//
//  File.swift
//  Stocks Help
//
//  Created by Lucas Oliveira on 21/08/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

protocol Background: UIViewController {
    func setupImageBackground()
}

extension Background {
    func setupImageBackground() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Background")
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 179)
        ])
    }
}
