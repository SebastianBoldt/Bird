//
//  RequestConverter.swift
//
//  Created by Sebastian Boldt on 07.07.19.
//

import Foundation

protocol RequestConverterProtocol {
    func convertRequest(requestDefinition: RequestDefinition) throws -> URLRequest
}

final class RequestConverter {
    
    enum URLRequestConvertibleError: Error {
        case couldNotCreate(description: String)
    }
    
    let urlCreator: URLCreatorProtocol
    let bodyPreparator: BodyPreparatorProtocol
    
    init(urlCreator: URLCreatorProtocol,
         bodyPreparator: BodyPreparatorProtocol) {
        self.urlCreator = urlCreator
        self.bodyPreparator = bodyPreparator
    }
}

extension RequestConverter: RequestConverterProtocol {
    public func convertRequest(requestDefinition: RequestDefinition) throws -> URLRequest {
        guard let url = try urlCreator.makeURL(from: requestDefinition) else {
            throw URLRequestConvertibleError.couldNotCreate(description: "Could not create components")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestDefinition.method.rawValue
        urlRequest.allHTTPHeaderFields = requestDefinition.headers

        guard let bodyParameterType = requestDefinition.bodyParameterType else {
            return urlRequest
        }
        return try self.bodyPreparator.prepareBody(of: urlRequest, with: bodyParameterType)
    }
}
