//
//  File.swift
//  
//
//  Created by Sebastian Boldt on 17.08.19.
//

import Foundation

public protocol Plugin {
    func prepare(request: URLRequest, definition: RequestDefinition) -> URLRequest
    func willSend(request: URLRequest, definition: RequestDefinition)
    func didReceive(result: URLSession.DataTaskPublisher.Output, definition: RequestDefinition)
    func process(result: DataTaskPublisherResponse) -> DataTaskPublisherResponse
}
