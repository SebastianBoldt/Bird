//
//  RequestConverter.swift
//
//  Created by Sebastian Boldt on 07.07.19.
//

import Foundation

protocol RequestConverterProtocol {
    func convertRequest(request: Request) throws -> URLRequest
}

final class RequestConverter: RequestConverterProtocol {
    public func convertRequest(request: Request) throws -> URLRequest {
        guard let url = try makeURL(from: request) else {
            throw URLRequestConvertibleError.couldNotCreate(description: "Could not create components")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        let requestWithParamters = try attachParameters(from: request, to: urlRequest)
        return requestWithParamters
    }
}

extension RequestConverter {
    private func makeURL(from request: Request) throws -> URL? {
        guard var components = URLComponents(string: request.url.absoluteString) else {
            throw URLRequestConvertibleError.couldNotCreate(description: "Could not create components")
        }
        
        components.scheme = request.scheme.stringValue
        components.path = request.path
        return components.url
    }
    
    private func attachParameters(from request: Request, to urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        switch request.requestType {
            case .plain:
                return urlRequest
            case .data(let data):
                urlRequest.httpBody = data
            case .jsonEncodable(let encodable):
                try addJSONEncodedBody(encodable: encodable, to: &urlRequest)
            case .customJSONEncodable(let encodable, let encoder):
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
