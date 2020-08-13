//
//  NewOperation.swift
//  Stocks Help
//
//  Created by Lucas Oliveira on 13/08/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class NewOperation: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLargeTitle()
        view.backgroundColor = .backgroundSH
        // Do any additional setup after loading the view.
    }
    
    func setupLargeTitle() {
        title = "Nova Operação"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textColorSH]
    }
}
