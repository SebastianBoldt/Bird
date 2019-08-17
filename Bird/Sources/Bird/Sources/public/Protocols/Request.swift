//
//  API.swift
//  
//
//  Created by Sebastian Boldt on 07.07.19.
//

import Foundation
/**
    The API protocol provides predefined properties for describing your API request
 */
public protocol Request {
    var scheme: HTTPScheme { get }
    var url: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var requestType: RequestType { get }
}
