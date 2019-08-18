//
//  URLRequestConvertible.swift
//
//  Created by Sebastian Boldt on 07.07.19.
//

import Foundation

/**
 Protocol that defines the function signatiure of an Object that is convertible to an ``URLRequest``
 */
public protocol URLRequestConvertible {
    func convertToURLRequest() throws -> URLRequest
}
