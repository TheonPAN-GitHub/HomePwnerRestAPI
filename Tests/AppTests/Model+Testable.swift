//
//  File.swift
//  
//
//  Created by Pan Qingrong on 2020/12/12.
//

@testable import App
import Fluent
import Vapor

extension Item {
    static func create(name : String = "MacBook Pro 16",
                       serialNumber :String? = nil,
                       valueInDollar : Int = 25000) throws -> Item {
        let item = Item(name:name,
                        valueInDollar:valueInDollar,
                        serialNumber:serialNumber,
                        dateCreated:Date())
        return item
    }
}

extension ItemImage {
    static func create(itemID:UUID) throws -> ItemImage {
        let itemImage = ItemImage(itemID: itemID, imageData: Data.init(count: 100))
        return itemImage
    }
}
