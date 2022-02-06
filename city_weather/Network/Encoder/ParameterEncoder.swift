//
//  ParameterEncoder.swift
//  city_weather
//
//  Created by Alejandro Guerra, 1/31/22.
//

import Foundation

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
