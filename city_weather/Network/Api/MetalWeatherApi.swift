//
//  MetalWeatherApi.swift
//  city_weather
//
//  Created by Alejandro Guerra, DSpot on 1/31/22.
//

import Foundation

enum MetalWeatherApi{
    case location(woeid: Int)
    case dayInformation(woeid: Int, year: Int, month: Int, day: Int)
}

extension MetalWeatherApi: TargetType{
    var baseURL: URL {
        URL.init(string: "https://www.metaweather.com/api")!
    }
    
    var path: String {
        switch self {
        case .location(let woeid):
            return "/location/\(woeid)/"
        case .dayInformation(let woeid,let year, let month, let day):
            return "/location/\(woeid)/\(year)/\(month)/\(day)/"
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String : Any] {
        [:]
    }
    
    var task: HTTPTask {
        .request
    }
    
    
}
