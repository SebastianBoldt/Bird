//
//  HTTPConstants.swift
//
//  Created by Sebastian Boldt on 17.08.19.
//

import Foundation

/**
    `HTTPConstants` contains all Constants related to HTTPRequests
 */
struct HTTPConstants {
    struct Header {
        struct Keys {
            static let contentType = "Content-Type"
        }
        
        struct Values {
            struct ContentType {
                static let applicationJSON = "application/json"
            }
        }
    }
}
