//
//  WeatherRepository.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 2/1/22.
//

import Foundation
import RxSwift

protocol WeatherRepositoryProtocol{
    func cities() -> Single<[City]>
    func location(by woeid: Int) -> Single<Location>
    func dayWeather(by woeid: Int, year: Int, month: Int, day: Int) -> Single<[ConsolidatedWeather]>
}

class WeatherRepository: WeatherRepositoryProtocol{
    private let provider: WeatherProviderProtocol
    
    init(provider: WeatherProviderProtocol){
        self.provider = provider
    }
    
    func location(by woeid: Int) -> Single<Location>{
        provider.location(by: woeid)
    }
    
    func dayWeather(by woeid: Int, year: Int, month: Int, day: Int) -> Single<[ConsolidatedWeather]>{
        provider.dayWeather(by: woeid, year: year, month: month, day: day)
    }
    
    func cities() -> Single<[City]>{
        Single.just([City.init(name: "Sofia", woeid: 839722), City.init(name: "NY", woeid: 2459115), City.init(name: "Tokyo", woeid: 1118370)])
    }
}
