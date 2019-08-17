//
//  API.swift
//  
//
//  Created by Sebastian Boldt on 07.07.19.
//

import Foundation

public protocol RequestDefinition {
    var scheme: Scheme { get }
    var url: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var urlParameters: [String: String] { get }
    var bodyParameterType: BodyParameterType? { get }
    var plugins: [Plugin] { get }
}
