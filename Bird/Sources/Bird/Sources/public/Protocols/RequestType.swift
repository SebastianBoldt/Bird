//
//  File.swift
//  
//
//  Created by Sebastian Boldt on 17.08.19.
//

import Foundation

public enum RequestType {
    // A Request made with no additional Data
    case plain
    
    // A Request with a body filled with data
    case data(data: Data)
    
    // A Request with encodable body
    case jsonEncodable(Encodable)
}
