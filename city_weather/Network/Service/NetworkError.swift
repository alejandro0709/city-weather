//
//  NetworkError.swift
//  city_weather
//
//  Created by Alejandro Guerra, 1/31/22.
//

import Foundation

enum NetworkError: Error{
    case parameterNils
    case failEncoding
    case missingURL
}
