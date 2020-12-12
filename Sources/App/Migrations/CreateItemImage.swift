//
//  File.swift
//  
//
//  Created by Pan Qingrong on 2020/12/12.
//

import Fluent

struct CreateItemImage : Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("item_images")
            .id()
            .field("item_id", .uuid, .required)
            .field("image_data", .data)
            .create()
    }
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("item_images").delete()
    }
}
