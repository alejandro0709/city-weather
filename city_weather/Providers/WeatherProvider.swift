//
//  WeatherProvider.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 1/31/22.
//

import Foundation
import RxSwift

protocol WeatherProviderProtocol{
    func location(by woeid: Int) -> Single<Location>
    func dayWeather(by woeid: Int, year: Int, month: Int, day: Int) -> Single<[ConsolidatedWeather]>
}

class WeatherProvider: WeatherProviderProtocol{
    private let service: Service<MetalWeatherApi>
    
    init(service: Service<MetalWeatherApi>){
        self.service = service
    }
    
    func location(by woeid: Int) -> Single<Location> {
        Single.create { observer in
            self.service.request(.location(woeid: woeid)) { result in
                switch result{
                case .success(data: let data):
                    guard let data = data,
                        let location = try? JSONDecoder().decode(Location.self, from: data) else {
                            observer(.failure(NetworkError.failDecoding))
                        return
                    }
                    observer(.success(location))
                case .failure(error: let error):
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func dayWeather(by woeid: Int, year: Int, month: Int, day: Int) -> Single<[ConsolidatedWeather]> {
        Single.create { observer in
            self.service.request(.dayInformation(woeid: woeid, year: year, month: month, day: day)) { result in
                switch result{
                case .success(data: let data):
                    guard let data = data,
                          let weatherList = try? JSONDecoder().decode([ConsolidatedWeather].self, from: data) else {
                              observer(.failure(NetworkError.failDecoding))
                              return
                          }
                    observer(.success(weatherList))
                case .failure(error: let error):
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}
