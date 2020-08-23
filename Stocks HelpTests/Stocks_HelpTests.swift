//
//  Stocks_HelpTests.swift
//  Stocks HelpTests
//
//  Created by Lucas Oliveira on 13/08/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import XCTest
@testable import Stocks_Help

class StocksHelpTests: XCTestCase {

    func test_api_Manager() {
        let apiManager = APIManager()
        XCTAssertThrowsError( try apiManager.requestPrice(assetCode: "AZULd"))
        
    }
    
    func test_VC_New_Operation_creatingAssetsRequest() {
        // case 1
        let newOperation = NewOperation()
        XCTAssertNil(newOperation.creatingAssetRequest())
        
        // case 2
        newOperation.qntyTF.textField.text = "1000"
        newOperation.priceTF.textField.text = "100"
        newOperation.assetsTF.textField.text = "AZUL4"
        
        XCTAssertEqual(Asset(symbol: "AZUL4", price: 100, qnty: 1000), newOperation.creatingAssetRequest())
        
    }
    
    func test_VC_New_Operation_buyAndSellLogic() {
        // case 1
        let newOperation = NewOperation()
        
        newOperation.qntyTF.textField.text = "1000"
        newOperation.priceTF.textField.text = "100"
        newOperation.assetsTF.textField.text = "AZUL4"
        
        XCTAssertTrue(newOperation.buyAndSellLogic())
        // case 2
        newOperation.qntyTF.textField.text = "asd"
        
        XCTAssertFalse(newOperation.buyAndSellLogic())
        
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
