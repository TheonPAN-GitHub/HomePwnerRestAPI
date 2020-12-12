//
//  File.swift
//  
//
//  Created by Pan Qingrong on 2020/12/12.
//

import XCTVapor
import App

extension Application {
    static func testable() throws -> Application {
        let testApp = Application(.testing)
        try configure(testApp)
        
        try testApp.autoRevert().wait()
        try testApp.autoMigrate().wait()
        
        return testApp
    }
}
