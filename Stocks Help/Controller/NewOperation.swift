//
//  NewOperation.swift
//  Stocks Help
//
//  Created by Lucas Oliveira on 13/08/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class NewOperation: UIViewController, Background {
    
    var operation: OperationType?
    
    let operationLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Tipo de Operação"
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        lbl.textColor = UIColor.textColorSH
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 114, height: 110)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.allowsSelection = true
        collectionView.register(OperationCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        collectionView.backgroundColor = .backgroundSH
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let assetsTF: TextFieldsOperation = {
        let txtField = TextFieldsOperation()
        txtField.labelTF.text = "Ativo"
        txtField.textField.placeholder = "AZUL4"
        
        txtField.translatesAutoresizingMaskIntoConstraints = false
        
        return txtField
    }()
    
    let qntyTF: TextFieldsOperation = {
        let txtField = TextFieldsOperation()
        txtField.labelTF.text = "Quantidade"
        txtField.textField.placeholder = "1000"
        txtField.textField.keyboardType = .numberPad
        
        txtField.translatesAutoresizingMaskIntoConstraints = false

        return txtField
    }()
    
    let priceTF: TextFieldsOperation = {
        let txtField = TextFieldsOperation()
        txtField.labelTF.text = "Preço"
        txtField.textField.placeholder = "R$ 14,50"
        txtField.textField.keyboardType = .decimalPad
        
        txtField.translatesAutoresizingMaskIntoConstraints = false

        return txtField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageBackground()
        setupLargeTitle()
        setupNaviButton()
        setupOperationLbl()
        setupCollectionView()
        setupAssetsTF()
        setupQntyTF()
        setupPriceTF()
        
        view.backgroundColor = .backgroundSH
        
    }
    
    // MARK: Setup funcs
    func setupLargeTitle() {
        title = "Nova Operação"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textColorSH]
    }
    
    func setupOperationLbl() {
        view.addSubview(operationLbl)
        
        NSLayoutConstraint.activate([
            operationLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            operationLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
        ])
    }
    
    func setupAssetsTF() {
        view.addSubview(assetsTF)
        assetsTF.textField.delegate = self
        
        NSLayoutConstraint.activate([
            assetsTF.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            assetsTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -38),
            assetsTF.heightAnchor.constraint(equalToConstant: 49),
            assetsTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
        ])
    }
    
    func setupQntyTF() {
        view.addSubview(qntyTF)
        
        NSLayoutConstraint.activate([
            qntyTF.topAnchor.constraint(equalTo: assetsTF.bottomAnchor, constant: 16),
            qntyTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -38),
            qntyTF.heightAnchor.constraint(equalToConstant: 49),
            qntyTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
        ])
    }
    
    func setupPriceTF() {
        view.addSubview(priceTF)
        
        NSLayoutConstraint.activate([
            priceTF.topAnchor.constraint(equalTo: qntyTF.bottomAnchor, constant: 16),
            priceTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -38),
            priceTF.heightAnchor.constraint(equalToConstant: 49),
            priceTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
        ])
    }
    
    func setupNaviButton() {
        let barButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(finalizeOperation))
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func finalizeOperation() {
        if buyAndSellLogic() {
            PlistManager().write()
        }
    }
    
    // MARK: Logic funcs
    
    func creatingAssetRequest() -> Asset? {
        
        var assetsCode = assetsTF.textField.text!
        var price = priceTF.textField.text!
        let qnty = qntyTF.textField.text!
        
        assetsCode = assetsCode.uppercased()
        price = price.replacingOccurrences(of: ",", with: ".")
        
        guard let qntyInt = Int(qnty), let priceDouble = Double(price) else {
            return nil
        }
        
        return Asset(symbol: assetsCode, price: priceDouble, qnty: qntyInt)
    }
    
    func buyAndSellLogic() -> Bool {
        let assetsRequest = creatingAssetRequest()
        guard let asset = assetsRequest else {
            return false
        }
        if operation == OperationType.buy {
            buy(asset: asset)
        } else {
            sell(asset: asset)
        }
        return true
    }
    
    func buy(asset: Asset) {
        
        let currentAssets = ListAssets.list.map({$0.symbol})
        
        if let index = currentAssets.firstIndex(of: asset.symbol) {
            ListAssets.list[index].qnty += asset.qnty
            ListAssets.list[index].price = (ListAssets.list[index].price + asset.price)/2
        } else {
            let asset = Asset(symbol: asset.symbol, price: asset.price, qnty: asset.qnty)
            do {
                // Verificando se a ação existe
                _ = try APIManager().requestPrice(assetCode: asset.symbol)
                ListAssets.list.append(asset)
            } catch {
                alert(self, title: "Erro", message: "\(asset.symbol), \(error.localizedDescription)")
            }
            
        }
    }
    
    func alert(_ presentFrom: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        presentFrom.present(alert, animated: true, completion: nil)
    }
    
    func sell(asset: Asset) {
        
        let currentAssets = ListAssets.list.map({$0.symbol})
        
        if let index = currentAssets.firstIndex(of: asset.symbol) {
            ListAssets.list[index].qnty -= asset.qnty
            
            if ListAssets.list[index].qnty <= 0 {
                ListAssets.list.remove(at: index)
            }
        }
    }
}

extension NewOperation: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension NewOperation: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: operationLbl.bottomAnchor, constant: 14),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: 271),
            collectionView.heightAnchor.constraint(equalToConstant: 110)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 1, animations: {
            if indexPath.row == 0 {
                let cell = collectionView.cellForItem(at: indexPath) as? OperationCollectionViewCell
                let otherCell = collectionView.cellForItem(at: [0, 1]) as? OperationCollectionViewCell
                
                cell?.smallToBig()
                otherCell?.bigToSmall()
                
                self.operation = .buy
                
            } else {
                let cell = collectionView.cellForItem(at: indexPath) as? OperationCollectionViewCell
                let otherCell = collectionView.cellForItem(at: [0, 0]) as? OperationCollectionViewCell
                
                cell?.smallToBig()
                otherCell?.bigToSmall()
                
                self.operation = .sell
            }
            
        })
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? OperationCollectionViewCell
        
        guard let validCell = cell else {
            return UICollectionViewCell()
        }
        
        if indexPath.row == 0 {
            validCell.label.text = "Comprar"
            validCell.coloredView.backgroundColor = UIColor.redSH.withAlphaComponent(0.5)
            validCell.icon.image = UIImage(named: "buy")
        } else {
            validCell.label.text = "Vender"
            validCell.coloredView.backgroundColor = UIColor.purpleSH.withAlphaComponent(0.5)
            validCell.icon.image = UIImage(named: "sell")
        }
        
        return validCell
    }
    
}
