//
//  RequestService.swift
//  
//  Created by Sebastian Boldt on 07.07.19.
//

import Foundation
import Combine

public typealias DataTaskPublisherResponse = AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure>

public protocol RequestServiceProtocol {
    func request(requestDefinition: RequestDefinition) throws -> DataTaskPublisherResponse
    func request<T: Decodable>(_ requestDefinition: RequestDefinition, responseType: T.Type) throws -> AnyPublisher<T, Error>
}

class RequestService: NSObject {
    private let converter: RequestConverterProtocol
    private static let decoder = JSONDecoder()
    
    init(converter: RequestConverterProtocol) {
        self.converter = converter
    }
}

extension RequestService: RequestServiceProtocol {
    public func request(requestDefinition: RequestDefinition) throws -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure> {
        let session = URLSession(configuration: .default)
        var urlRequest = try converter.convertRequest(requestDefinition: requestDefinition)
        
        urlRequest = makePreRequestPluginCalls(definition: requestDefinition, to: urlRequest)
        
        return URLSession.DataTaskPublisher(request: urlRequest, session: session).map { data, response -> URLSession.DataTaskPublisher.Output  in
            requestDefinition.plugins.forEach {
                let result: URLSession.DataTaskPublisher.Output = (data: data, response: response)
                $0.didReceive(result: result, definition: requestDefinition)
            }
            
            return (data: data, response: response)
        }.eraseToAnyPublisher()
    }
    
    public func request<T: Decodable>(_ requestDefinition: RequestDefinition,
                                      responseType: T.Type) throws -> AnyPublisher<T, Error>{
        let session = URLSession(configuration: .default)
        var urlRequest = try converter.convertRequest(requestDefinition: requestDefinition)
        
        urlRequest = makePreRequestPluginCalls(definition: requestDefinition, to: urlRequest)

        let publisher = URLSession.DataTaskPublisher(request: urlRequest, session: session)
        return publisher.map { return $0.data }
                        .decode(type: responseType, decoder: RequestService.decoder).eraseToAnyPublisher()
    }
}

extension RequestService {
    func makePreRequestPluginCalls(definition: RequestDefinition, to urlRequest: URLRequest) -> URLRequest {
        var urlRequest = urlRequest
        
        definition.plugins.forEach {
            urlRequest = $0.prepare(request: urlRequest, definition: definition)
        }
        
        definition.plugins.forEach {
            $0.willSend(request: urlRequest, definition: definition)
        }
        
        return urlRequest
    }
}
