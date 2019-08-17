//
//  AnyEncodable.swift
//
//  Created by Sebastian Boldt on 17.08.19.
//

import Foundation

struct AnyEncodable {
    private let encodable: Encodable
    
    init(encodable: Encodable) {
        self.encodable = encodable
    }
}

extension AnyEncodable: Encodable {
    func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
}
