//
//  WeatherRepository.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 2/1/22.
//

import Foundation
import RxSwift

protocol WeatherRepositoryProtocol{
    func allLocations() -> Single<[Location]>
    func location(by woeid: Int, cacheDataCompletion: @escaping((Location) -> ())) -> Single<Location>
    func dayWeather(by woeid: Int,from id: Int, year: Int, month: Int, day: Int, cacheDataCompletion: @escaping(([ConsolidatedWeather]) -> ())) -> Single<[ConsolidatedWeather]>
    func searchLocationByTitle(title: String) -> Single<[Location]>
    func addLocation(woeid: Int, title: String) -> Completable
}

class WeatherRepository: WeatherRepositoryProtocol{
    private let provider: WeatherProviderProtocol
    private let cache: WeatherDataCacheProtocol
    
    init(provider: WeatherProviderProtocol, cache: WeatherDataCacheProtocol){
        self.provider = provider
        self.cache = cache
    }
    
    func location(by woeid: Int, cacheDataCompletion: @escaping((Location) -> ())) -> Single<Location>{
        provider.location(by: woeid)
            .do(onSuccess:{ locationItem in
                self.cache.saveFullLocation(location: locationItem)
            }, onSubscribe: {
                guard let location = self.cache.location(by: woeid) else { return }
                cacheDataCompletion(location)
            })
    }
    
    func dayWeather(by woeid: Int, from id: Int, year: Int, month: Int, day: Int, cacheDataCompletion: @escaping(([ConsolidatedWeather]) -> ())) -> Single<[ConsolidatedWeather]>{
        provider.dayWeather(by: woeid, year: year, month: month, day: day)
            .do(onSuccess:{ list in
                self.cache.createOrUpdateConsolidatedWeather(list: list, cwId: id)
            }, onSubscribe: {
                cacheDataCompletion(self.cache.consolidatedWeather(with: id))
            })
    }
    
    func allLocations() -> Single<[Location]>{
        let locationList = cache.allLocations()
        if locationList.isEmpty {
            cache.createDefaultLocations()
            return Single.just([Location.init(title: "Sofia", woeid: 839722), Location.init(title: "NY", woeid: 2459115), Location.init(title: "Tokyo", woeid: 1118370)])
        }
        
        return Single.just(locationList)
    }
    
    func searchLocationByTitle(title: String) -> Single<[Location]>{
        provider.searchLocationByTitle(title: title)
    }
    
    func addLocation(woeid: Int, title: String) -> Completable{
        Completable.create { observer in
            if self.cache.createBasicLocation(woeid: woeid, title: title){
                observer(.completed)
            } else {
                observer(.error(EntityError.createEntityFail))
            }
            return Disposables.create()
        }
    }
}
