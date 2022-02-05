//
//  NetworkError.swift
//  city_weather
//
//  Created by Alejandro Guerra, 1/31/22.
//

import Foundation

enum NetworkError: String, Error{
    case parameterNils = "Parameters are empty."
    case failEncoding = "Error encoding data in json."
    case missingURL = "URL was not set."
    case failDecoding = "Fail decoding data from json. Received data is not in the expected format."
}

enum NetworkErrorResponse: String,Error{
    case authenticationError = "Failed authentication"
    case badRequest = "Bad request"
    case outdated = "Request is outdated"
    case failed = "An error occurred. Unable to gather requested information."
}

enum ImageError: Error{
    case fileNotFound
    case invalidPath
}
