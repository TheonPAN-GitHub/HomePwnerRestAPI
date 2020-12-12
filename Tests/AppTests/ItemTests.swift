//
//  File.swift
//  
//
//  Created by Pan Qingrong on 2020/12/12.
//

@testable  import App
import XCTVapor

final class ItemTests : XCTestCase {
    var testApp : Application!
    var itemURI = "/api/items"
    
    override func setUpWithError() throws {
        testApp = try Application.testable()
    }
    
    func testItemCanBeSavedWithAPI() throws {
        let item = try Item.create(name: "MacBook Pro", serialNumber: "123456", valueInDollar: 25000)
        try testApp.test(.POST, itemURI, beforeRequest :{req in
            try req.content.encode(item)
        }, afterResponse: {response in
            let receivedItem = try response.content.decode(Item.self)
            XCTAssertEqual(receivedItem.name, item.name)
            XCTAssertEqual(receivedItem.serialNumber, item.serialNumber)
            XCTAssertEqual(receivedItem.valueInDollar, item.valueInDollar)
            XCTAssertNotNil(receivedItem.id)
            XCTAssertNotNil(receivedItem.dateCreated)
            
        })
        
        try testApp.test(.GET, itemURI, afterResponse: {secondResponse in
            let items = try secondResponse.content.decode([Item].self)
            
            XCTAssertEqual(items.count, 1)
            XCTAssertEqual(items[0].name, item.name)
            XCTAssertEqual(items[0].serialNumber, item.serialNumber)
            XCTAssertEqual(items[0].valueInDollar, item.valueInDollar)
            XCTAssertNotNil(items[0].id)
            XCTAssertNotNil(items[0].dateCreated)
        })
        XCTAssertEqual("true", "true")
    }
    
    override func tearDownWithError() throws {
        testApp.shutdown()
    }
    
}
