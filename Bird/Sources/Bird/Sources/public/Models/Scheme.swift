//
//  File.swift
//  
//  Created by Sebastian Boldt on 07.07.19.
//

import Foundation

public enum Scheme {
    case http
    case https
    case custom(scheme: String)
}

extension Scheme {
    public var stringValue: String {
        switch self {
            case .http:
                return "http"
            case .https:
                return "https"
            case .custom(let scheme):
                return scheme
        }
    }
}
