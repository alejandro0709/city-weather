//
//  LocationDayPresenter.swift
//  city_weather
//
//  Created by Alejandro Guerra on 2/5/22.
//

import Foundation

protocol LocationDayPresenterProtocol: BasePresenterProtocol{
    func loadWeatherData(forecast: [ConsolidatedWeather])
    func setupDisplayer(viewcontroller: LocationForecastDisplayer)
}

class LocationDayPresenter: LocationDayPresenterProtocol{
    private var viewcontroller: LocationForecastDisplayer?
    
    func setupDisplayer(viewcontroller: LocationForecastDisplayer){
        self.viewcontroller = viewcontroller
    }
    
    func networkState(state: NetworkState){
        viewcontroller?.networkState(state: state)
    }
    
    func errorDetected(error: Error, retryAction: (() -> ())?){
        viewcontroller?.errorDetected(error: error, retryAction: retryAction)
    }
    
    func loadWeatherData(forecast: [ConsolidatedWeather]){
        viewcontroller?.loadForecast(itemList: forecast.map({ cw in
            ForecastDayCollectionViewCellViewModel.init(weather: cw, dayDetails: true)
        }).sorted(by: { lhs, rhs in
            lhs.created > rhs.created
        }))
    }
}
