//
//  File.swift
//  
//
//  Created by Theon.PAN on 2020/12/11.
//

import Vapor
import Fluent

struct ItemController : RouteCollection{
    func boot(routes: RoutesBuilder) throws {
        let itemRoutesGroup = routes.grouped("api", "items")
        itemRoutesGroup.post(use: createHandler)
        itemRoutesGroup.get(use : getAllHandler)
        itemRoutesGroup.put(":itemID", use : updateHandler)
    }
    
    func createHandler(_ req : Request) throws -> EventLoopFuture<Item> {
        print(req.body.string)
        let itemFromRequest = try req.content.decode(Item.self)
        
        return itemFromRequest.save(on: req.db).map{itemFromRequest}
    }
    
    func getAllHandler(_ req:Request) throws -> EventLoopFuture<[Item]> {
        return Item.query(on:req.db).all()
    }
    
    func updateHandler(_ req:Request) throws -> EventLoopFuture<Item> {
        let updatedItem = try req.content.decode(Item.self)
        return Item.find(req.parameters.get("itemID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{ item in
                item.name = updatedItem.name
                item.serialNumber = updatedItem.serialNumber
                item.valueInDollars = updatedItem.valueInDollars
                item.dateCreated = updatedItem.dateCreated
                return item.save(on: req.db).map{
                    item
                }
            }
    }
}
