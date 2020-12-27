//
//  File.swift
//  
//
//  Created by Theon.PAN on 2020/12/11.
//

import Vapor
import Fluent

final class Item : Model, Content {
    static let schema = "items"
    
    @ID
    var id:UUID?
    
    @Field(key: "name")
    var name:String
    
    @Field(key: "value_in_dollar")
    var valueInDollars:Int
    
    @Field(key: "serial_number")
    var serialNumber:String?
    
    @Field(key: "date_created")
    var dateCreated:Date
    
    init(){}
    
    init(id:UUID? = nil, name:String, valueInDollars:Int, serialNumber:String? = nil, dateCreated:Date){
        self.id = id
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = dateCreated
    }
}
