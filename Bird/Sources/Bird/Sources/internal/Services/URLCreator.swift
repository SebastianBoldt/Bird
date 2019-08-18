//
//  URLCreator.swift
//
//  Created by Sebastian Boldt on 18.08.19.
//

import Foundation

protocol URLCreatorProtocol {
    func makeURL(from requestDefinition: RequestDefinition) throws -> URL?
    func makeQueryString(from parameters: [String: String]) throws -> String
}

struct URLCreator: URLCreatorProtocol {
    func makeURL(from requestDefinition: RequestDefinition) throws -> URL? {
        var components = URLComponents()
        components.host = requestDefinition.url
        components.query = try makeQueryString(from: requestDefinition.urlParameters)
        components.scheme = requestDefinition.scheme.stringValue
        components.path = requestDefinition.path
        return components.url
    }
    
    func makeQueryString(from parameters: [String: String]) throws -> String {
        var components: [(String, String)] = []
        for key in parameters.keys {
            guard let value = parameters[key] else { continue }
            components.append((key, value))
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
}
