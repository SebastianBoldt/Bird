//
//  File.swift
//  
//
//  Created by Sebastian Boldt on 17.08.19.
//

import Foundation

public enum BodyParameterType {
    case data(Data)
    case JSON(Encodable)
    case customJSON(Encodable, encoder: JSONEncoder)
}
