//
//  LocationDayInteractor.swift
//  city_weather
//
//  Created by Alejandro Guerra on 2/5/22.
//

import Foundation
import RxSwift

protocol LocationDayInteractorProtocol{
    func requestForecastData(woeid: Int, applicableDate: Date, wsId: Int)
}

class LocationDayInteractor: LocationDayInteractorProtocol{
    private let repository: WeatherRepositoryProtocol
    private let presenter: LocationDayPresenterProtocol
    private let disposeBag = DisposeBag()
    
    init(repository: WeatherRepositoryProtocol, presenter: LocationDayPresenterProtocol){
        self.repository = repository
        self.presenter = presenter
    }
    
    func requestForecastData(woeid: Int, applicableDate: Date, wsId: Int){
        presenter.networkState(state: .loading)
        repository.dayWeather(by: woeid, from: wsId, year: Calendar.current.component(.year, from: applicableDate),
                              month: Calendar.current.component(.month, from: applicableDate),
                              day: Calendar.current.component(.day, from: applicableDate), cacheDataCompletion: { cwList in
            self.presenter.loadWeatherData(forecast: cwList)
        })
            .subscribe { weatherList in
                self.presenter.networkState(state: .success)
                self.presenter.loadWeatherData(forecast: weatherList)
            } onFailure: { error in
                self.presenter.networkState(state: .error)
                self.presenter.errorDetected(error: error) {
                    self.requestForecastData(woeid: woeid, applicableDate: applicableDate, wsId: wsId)
                }
            }.disposed(by: disposeBag)
    }
    
}
