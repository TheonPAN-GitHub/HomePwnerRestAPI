//
//  File.swift
//  
//
//  Created by Theon.PAN on 2020/12/11.
//

import Fluent

struct CreateItem : Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("items")
            .id()
            .field("name", .string, .required)
            .field("value_in_dollar", .int, .required)
            .field("serial_number", .string)
            .field("date_created", .date, .required)
            .create()
    }
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("items").delete()
    }
}
