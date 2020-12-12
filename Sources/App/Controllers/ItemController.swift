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
        
    }
    
    func createHandler(_ req : Request) throws -> EventLoopFuture<Item> {
        let itemFromRequest = try req.content.decode(Item.self)
        
        return itemFromRequest.save(on: req.db).map{itemFromRequest}
    }
    
    func getAllHandler(_ req:Request) throws -> EventLoopFuture<[Item]> {
        return Item.query(on:req.db).all()
    }
}
