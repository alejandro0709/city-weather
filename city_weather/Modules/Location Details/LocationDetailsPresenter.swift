//
//  LocationDetailsPresenter.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 2/2/22.
//

import Foundation

protocol LocationDetailsPresenterProtocol{
    func setupDisplayer(viewcontroller: LocationDetailsDisplayer)
    func networkState(state: NetworkState)
    func errorDetected(error: Error, retryAction: (() -> ())?)
    func locationDetails(location: Location)
}

class LocationDetailsPresenter: LocationDetailsPresenterProtocol{
    private var viewcontroller: LocationDetailsDisplayer?
    
    func setupDisplayer(viewcontroller: LocationDetailsDisplayer){
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
        }) ?? [])
    }
}
