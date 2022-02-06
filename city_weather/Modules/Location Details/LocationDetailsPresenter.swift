//
//  LocationDetailsPresenter.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 2/2/22.
//

import Foundation

protocol LocationDetailsPresenterProtocol: BasePresenterProtocol{
    func setupDisplayer(viewcontroller: LocationForecastDisplayer)
    func locationDetails(location: Location)
}

class LocationDetailsPresenter: LocationDetailsPresenterProtocol{
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
    
    func locationDetails(location: Location){
        viewcontroller?.loadForecast(itemList: location.consolidated_weather?.map({ item -> ForecastDayCollectionViewCellViewModel in
            ForecastDayCollectionViewCellViewModel.init(weather: item)
        }).sorted(by: { lhs, rhs in
            lhs.applicableDate < rhs.applicableDate
        }) ?? [])
    }
}
