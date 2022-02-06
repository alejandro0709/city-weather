//
//  MetalWeatherApi.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 1/31/22.
//

import Foundation

enum MetalWeatherApi{
    case location(woeid: Int)
    case dayInformation(woeid: Int, year: Int, month: Int, day: Int)
    case image(name: String)
    case searchLocation(query: String)
}

extension MetalWeatherApi: TargetType{
    var baseURL: URL {
        URL.init(string: "https://www.metaweather.com")!
    }
    
    var path: String {
        switch self {
        case .location(let woeid):
            return "/api/location/\(woeid)/"
        case .dayInformation(let woeid,let year, let month, let day):
            return "/api/location/\(woeid)/\(year)/\(month)/\(day)/"
        case .image(let name):
            return "/static/img/weather/png/64/\(name).png"
        case .searchLocation:
            return "/api/location/search/"
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String : Any] {
        [:]
    }
    
    var task: HTTPTask {
        switch self{
        case .searchLocation(let query): return .requestParameters(body: nil, urlQuery: ["query": query])
        default: return .request
        }
    }
    
    
}
