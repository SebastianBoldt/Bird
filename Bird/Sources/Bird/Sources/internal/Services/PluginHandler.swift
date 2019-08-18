//
//  File.swift
//  
//
//  Created by Sebastian Boldt on 18.08.19.
//

import Foundation

protocol PluginHandlerProtocol {
    func makePostRequestPluginCalls(_ data: Data, _ response: URLResponse, _ requestDefinition: RequestDefinition)
    func makePreRequestPluginCalls(definition: RequestDefinition, to urlRequest: URLRequest) -> URLRequest
}

struct PluginHandler: PluginHandlerProtocol {
    func makePostRequestPluginCalls(_ data: Data, _ response: URLResponse, _ requestDefinition: RequestDefinition) {
        requestDefinition.plugins.forEach {
            let result: URLSession.DataTaskPublisher.Output = (data: data, response: response)
            $0.didReceive(result: result, definition: requestDefinition)
        }
    }
    
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
