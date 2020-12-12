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
        let itemRoutesGroup = routes.grouped("api", "item")
        itemRoutesGroup.post(use: createHandler(<#T##req: Request##Request#>))
        
    }
    
    func createHandler(_ req : Request) throws -> EventLoopGroup<Item> {
        let itemFromRequest = req.content.decode(Item.self)
        
        return itemFromRequest.save(on: req.db).map{itemFromRequest}
    }
}
