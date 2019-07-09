//
//  RequestService.swift
//  
//
//  Created by Sebastian Boldt on 07.07.19.
//

import Foundation
import Combine

public protocol RequestServiceProtocol {
    func request<T>(_ request: Request,
                    responseType: T.Type) throws -> AnyPublisher<T, Error> where T : Decodable
}

class RequestService: NSObject, RequestServiceProtocol {
    let converter: RequestConverterProtocol
    
    init(converter: RequestConverterProtocol) {
        self.converter = converter
    }
    
    private static let decoder = JSONDecoder()
    
    public func request<T: Decodable>(_ request: Request,
                                      responseType: T.Type) throws -> AnyPublisher<T, Error>{
        let session = URLSession(configuration: .default)
        let urlRequest = try converter.convertRequest(request: request)
        let publisher = URLSession.DataTaskPublisher(request: urlRequest, session: session)
        
        return publisher
                    .map { $0.data }
                    .decode(type: responseType, decoder: RequestService.decoder)
                    .eraseToAnyPublisher()
    }
}
