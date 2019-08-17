//
//  RequestService.swift
//  
//  Created by Sebastian Boldt on 07.07.19.
//

import Foundation
import Combine

public typealias DataTaskPublisherResponse = AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure>

public protocol RequestServiceProtocol {
    func request(request: Request) throws -> DataTaskPublisherResponse
    func request<T: Decodable>(_ request: Request, responseType: T.Type) throws -> AnyPublisher<T, Error>
}

class RequestService: NSObject {
    private let converter: RequestConverterProtocol
    private static let decoder = JSONDecoder()
    
    init(converter: RequestConverterProtocol) {
        self.converter = converter
    }
}

extension RequestService: RequestServiceProtocol {
    public func request(request: Request) throws -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure> {
        let session = URLSession(configuration: .default)
        let urlRequest = try converter.convertRequest(request: request)
        return URLSession.DataTaskPublisher(request: urlRequest, session: session).eraseToAnyPublisher()
    }
    
    public func request<T: Decodable>(_ request: Request,
                                      responseType: T.Type) throws -> AnyPublisher<T, Error>{
        let session = URLSession(configuration: .default)
        let urlRequest = try converter.convertRequest(request: request)
        let publisher = URLSession.DataTaskPublisher(request: urlRequest, session: session)
        
        return publisher.map { return $0.data }
                        .decode(type: responseType, decoder: RequestService.decoder).eraseToAnyPublisher()
    }
}
