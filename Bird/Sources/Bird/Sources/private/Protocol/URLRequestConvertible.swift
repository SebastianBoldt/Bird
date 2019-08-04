//
//  File.swift
//  
//
//  Created by Sebastian Boldt on 07.07.19.
//

import Foundation

enum URLRequestConvertibleError: Error {
    case couldNotCreate(description: String)
}

public protocol URLRequestConvertible {
    func convertToURLRequest() throws -> URLRequest
}
