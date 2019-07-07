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
public protocol Request: URLRequestConvertible {
    var scheme: HTTPScheme { get }
    var url: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Codable] { get }
    var headers: [String: String] { get }
}

extension Request {
    //TODO: Move to separate Service
    public func convertToURLRequest() throws -> URLRequest {
        guard var components = URLComponents(string: self.url.absoluteString) else {
            throw URLRequestConvertibleError.couldNotCreate(description: "Could not create components")
        }
        
        components.scheme = self.scheme.stringValue
        components.path = self.path

        guard let url = components.url else {
            throw URLRequestConvertibleError.couldNotCreate(description: "Could not create components")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        // Prepare Headers
        for (key, value) in headers {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        //TODO: Prepare Parameters
        
        return urlRequest
    }
}
