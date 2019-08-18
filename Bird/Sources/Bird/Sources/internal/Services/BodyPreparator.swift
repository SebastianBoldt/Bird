//
//  File.swift
//  
//
//  Created by Sebastian Boldt on 18.08.19.
//

import Foundation

protocol BodyPreparatorProtocol {
    func prepareBody(of urlRequest: URLRequest,
                     with bodyParameterType: BodyParameterType) throws -> URLRequest
    func addJSONEncodedBody(encodable: Encodable,
                            encoder: JSONEncoder,
                            to urlRequest: inout URLRequest) throws
}

struct BodyPreparator: BodyPreparatorProtocol {
    func prepareBody(of urlRequest: URLRequest, with bodyParameterType: BodyParameterType) throws -> URLRequest {
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
