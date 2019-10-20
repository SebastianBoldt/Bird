//
//  API.swift
//  
//
//  Created by Sebastian Boldt on 07.07.19.
//

import Foundation

public protocol RequestDefinition {
    var scheme: Scheme { get }
    var url: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var urlParameters: [String: String] { get }
    var bodyParameterType: BodyParameterType? { get }
    var plugins: [Plugin] { get }
}

public extension RequestDefinition {
    var scheme: Scheme { return .https }
    var headers: [String: String] { return [:] }
    var urlParameters: [String: String] { return [:] }
    var bodyParameterType: BodyParameterType? { return nil }
    var plugins: [Plugin] { return [] }
}
