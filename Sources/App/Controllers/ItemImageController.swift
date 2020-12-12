//
//  File.swift
//  
//
//  Created by Pan Qingrong on 2020/12/12.
//

import Vapor
import Fluent

struct ItemImageController : RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let itemImageRoutes = routes.grouped("api", "items", ":itemID", "images")
        itemImageRoutes.post(use:createHandler(_:))
    }
    
    func createHandler(_ req:Request) throws -> EventLoopFuture<ItemImage> {
        let itemImage = try req.content.decode(ItemImage.self)
        return Item.find(req.parameters.get("itemID"), on: req.db)
            .unwrap(or: Abort(.notFound)).flatMap { item in
                itemImage.itemID = item.id
                return itemImage.save(on: req.db).map{itemImage}
            }
    }
    
    func getHandler(_ req:Request) throws -> EventLoopFuture<ItemImage> {
        guard let itemIDString = req.parameters.get("itemID") else {
            throw Abort(.badRequest)
        }
        
        let itemID = UUID.init(uuidString: itemIDString)
        let _ = Item.find(req.parameters.get("itemID"), on: req.db).unwrap(or: Abort(.notFound))
        return ItemImage.query(on: req.db).group(.or){ or in
            or.filter(\.$itemID == itemID)
        }.first()
        .unwrap(or: Abort(.notFound))
            
    }
}
