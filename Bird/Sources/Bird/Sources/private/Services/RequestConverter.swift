//
//  RequestConverter.swift
//
//  Created by Sebastian Boldt on 07.07.19.
//

import Foundation

protocol RequestConverterProtocol {
    func convertRequest(requestDefinition: RequestDefinition) throws -> URLRequest
}

final class RequestConverter: RequestConverterProtocol {
    public func convertRequest(requestDefinition: RequestDefinition) throws -> URLRequest {
        guard let url = try makeURL(from: requestDefinition) else {
            throw URLRequestConvertibleError.couldNotCreate(description: "Could not create components")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestDefinition.method.rawValue
        urlRequest.allHTTPHeaderFields = requestDefinition.headers

        guard let bodyParamterType = requestDefinition.bodyParameterType else {
            return urlRequest
        }
        return try prepareBody(of: urlRequest, with: bodyParamterType)
    }
}

extension RequestConverter {
    private func makeURL(from requestDefinition: RequestDefinition) throws -> URL? {
        guard var components = URLComponents(string: requestDefinition.url.absoluteString) else {
            throw URLRequestConvertibleError.couldNotCreate(description: "Could not create components")
        }
        
        components.query = try makeQueryString(from: requestDefinition.urlParameters)
        components.scheme = requestDefinition.scheme.stringValue
        components.path = requestDefinition.path
        return components.url
    }
    
    private func prepareBody(of urlRequest: URLRequest, with bodyParameterType: BodyParameterType) throws -> URLRequest {
        var urlRequest = urlRequest
        switch bodyParameterType {
            case .data(let data):
                urlRequest.httpBody = data
            case .JSON(let encodable):
                try addJSONEncodedBody(encodable: encodable, to: &urlRequest)
            case .customJSON(let encodable, let encoder):
                try addJSONEncodedBody(encodable: encodable, encoder: encoder, to: &urlRequest)
        }
        
        return urlRequest
    }
}

extension RequestConverter {
    func addJSONEncodedBody(encodable: Encodable,
                            encoder: JSONEncoder = JSONEncoder(),
                            to urlRequest: inout URLRequest) throws {
        let anyEncodable = AnyEncodable(encodable: encodable)
        urlRequest.httpBody = try encoder.encode(anyEncodable)

        let contentTypeHeaderName = HTTPConstants.Header.Keys.contentType
        if urlRequest.value(forHTTPHeaderField: contentTypeHeaderName) == nil {
            urlRequest.setValue(HTTPConstants.Header.Values.ContentType.applicationJSON,
                                forHTTPHeaderField: contentTypeHeaderName)
        }
    }
}

extension RequestConverter {
    private func makeQueryString(from parameters: [String: String]) throws -> String {
        var components: [(String, String)] = []

        for key in parameters.keys {
            guard let value = parameters[key] else {
                continue
            }
            components.append((key, value))
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
}
