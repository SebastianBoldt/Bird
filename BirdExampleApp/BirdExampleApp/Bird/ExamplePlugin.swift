//
//  ExamplePlugin.swift
//  BirdExampleApp
//
//  Created by Sebastian Boldt on 17.08.19.
//  Copyright © 2019 Sebastian Boldt. All rights reserved.
//

import Bird
import Foundation

struct ExamplePlugin: Plugin {
    func didReceive(result: URLSession.DataTaskPublisher.Output, definition: RequestDefinition) {
        
    }
    
    func process(result: DataTaskPublisherResponse) -> DataTaskPublisherResponse {
        return result
    }
    
    func prepare(request: URLRequest, definition: RequestDefinition) -> URLRequest {
        print(#function)
        return request
    }
    
    func willSend(request: URLRequest, definition: RequestDefinition) {
        print(#function)
    }
    
    func didReceive(result: DataTaskPublisherResponse, definition: RequestDefinition) {
        print(#function)
    }
}
