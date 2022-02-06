//
//  JSONParameterEncoded.swift
//  city_weather
//
//  Created by Alejandro Guerra, 1/31/22.
//

import Foundation

struct JSONParameterEncoded: ParameterEncoder{
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard urlRequest.url != nil else { throw NetworkError.missingURL }
        guard let jsonAsData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) else {
            throw NetworkError.failEncoding
        }
        
        urlRequest.httpBody = jsonAsData
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
    
    
}
