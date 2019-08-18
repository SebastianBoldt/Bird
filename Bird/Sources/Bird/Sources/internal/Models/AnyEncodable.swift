//
//  AnyEncodable.swift
//
//  Created by Sebastian Boldt on 17.08.19.
//

import Foundation

/**
 ``AnyEncodable`` is a Type that boxes any ``Encodable`` Object
 so it can be used where Protocols can't
*/
struct AnyEncodable {
    private let encodable: Encodable
    
    /**
     - Parameter encodable: The boxed object
     */
    init(encodable: Encodable) {
        self.encodable = encodable
    }
}

extension AnyEncodable: Encodable {
    func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
}
