//
//  File.swift
//  
//
//  Created by Sebastian Boldt on 07.07.19.
//

import Foundation
import Combine

protocol RequestServiceProtocol {
    func request<T>(_ request: Request, responseType: T.Type) throws -> AnyPublisher<T, Error> where T : Decodable
}

public class RequestService: NSObject, RequestServiceProtocol {
    private static let decoder = JSONDecoder()

    public func request<T: Decodable>(_ request: Request, responseType: T.Type) throws -> AnyPublisher<T, Error>{
        let session = URLSession(configuration: .default)
        let urlRequest = try request.convertToURLRequest()
        let publisher = URLSession.DataTaskPublisher(request: urlRequest, session: session)
        
        return publisher
                    .map { $0.data }
                    .decode(type: responseType, decoder: RequestService.decoder)
                    .eraseToAnyPublisher()
    }
}
