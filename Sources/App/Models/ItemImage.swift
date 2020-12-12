//
//  File.swift
//  
//
//  Created by Pan Qingrong on 2020/12/12.
//
import Vapor
import Fluent

final class ItemImage : Model, Content {
    static let schema = "item_images"
    
    @ID
    var id : UUID?
    
    @Field(key : "item_id")
    var itemID : UUID!
    
    @Field(key : "image_data")
    var imageData : Data
    
    init() {}
    
    init(id:UUID?=nil, itemID:UUID, imageData:Data) {
        self.id = id
        self.itemID = itemID
        self.imageData = imageData
    }
    
}
