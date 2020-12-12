import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }

    let itemController = ItemController()
    try app.register(collection: itemController)
    
    let itemImageController = ItemImageController()
    try app.register(collection: itemImageController)
}
