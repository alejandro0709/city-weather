//
//  TargetType.swift
//  city_weather
//
//  Created by Alejandro Guerra, 1/31/22.
//

import Foundation

public typealias Parameters = [String:Any]
public typealias HTTPHeaders = [String:String]

public enum HTTPMethod: String{
    case post = "POST"
    case put = "PUT"
    case get = "GET"
    case delete = "DELETE"
    case patch = "PATCH"
}

public enum HTTPTask{
    case request
    case requestParameters(body: Parameters?, urlQuery: Parameters?)
    case requestParametersWithHeaders(body: Parameters?, urlQuery: Parameters?, headers: HTTPHeaders?)
}

public protocol TargetType{
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: Any] { get }
    var task: HTTPTask { get }
}
