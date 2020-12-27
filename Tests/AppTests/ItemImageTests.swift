//
//  File.swift
//  
//
//  Created by Pan Qingrong on 2020/12/12.
//

@testable import App
import XCTVapor

final class ItemImageTests : XCTestCase {
    var itemURI = "/api/items"
    var imageURI = "/images"
    var testApp : Application!
    override func setUpWithError() throws {
        testApp = try Application.testable()
    }
    
    func testItemImageCanBeSavedWithAPI() throws {
        let item = try Item.create(name: "MacBook Pro", serialNumber: "123456", valueInDollars: 25000)
        try testApp.test(.POST, itemURI, beforeRequest :{req in
            try req.content.encode(item)
        }, afterResponse: {response in
            let receivedItem = try response.content.decode(Item.self)
            XCTAssertEqual(receivedItem.name, item.name)
            XCTAssertEqual(receivedItem.serialNumber, item.serialNumber)
            XCTAssertEqual(receivedItem.valueInDollars, item.valueInDollars)
            XCTAssertNotNil(receivedItem.id)
            XCTAssertNotNil(receivedItem.dateCreated)
            
            let itemImage = try ItemImage.create(itemID: receivedItem.id!)
            try testApp.test(.POST, itemURI + "/" + receivedItem.id!.uuidString + imageURI,
                             beforeRequest : { req in
                                try req.content.encode(itemImage)
                             },
                             afterResponse: {response in
                                let itemImageReceivevd = try response.content.decode(ItemImage.self)
                                XCTAssertEqual(itemImageReceivevd.itemID, itemImage.itemID)
                                XCTAssertEqual(itemImageReceivevd.imageData, itemImage.imageData)
                                XCTAssertNotNil(itemImageReceivevd.id)
                             })
        })
        
    }
    
    override func tearDownWithError() throws {
        testApp.shutdown()
    }
}
