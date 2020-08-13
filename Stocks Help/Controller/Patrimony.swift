//
//  ViewController.swift
//  Stocks Help
//
//  Created by Lucas Oliveira on 13/08/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class Patrimony: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLargeTitle()
        setupNavControllerButton()
        view.backgroundColor = .backgroundSH
        // Do any additional setup after loading the view.
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

}
