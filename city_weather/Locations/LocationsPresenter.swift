//
//  CitiesPresenter.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 2/1/22.
//

import Foundation
protocol LocationsPresenterProtocol{
    func setupDisplayer(viewController: LocationsDisplayerProtocol)
    func networkState(state: NetworkState)
    func errorDetected(error: Error, retryAction: (() ->())?)
    func loadLocations(locationList: [City])
}

class LocationsPresenter: LocationsPresenterProtocol{
    private var viewController: LocationsDisplayerProtocol?
    
    func setupDisplayer(viewController: LocationsDisplayerProtocol){
        self.viewController = viewController
    }
    
    func networkState(state: NetworkState){
        viewController?.networkState(state: state)
    }
    
    func errorDetected(error: Error, retryAction: (() ->())?){
        
    }
    
    func loadLocations(locationList: [City]){
        viewController?.loadLocations(locationList: locationList.map({ city -> LocationTableViewCellViewModel in
            LocationTableViewCellViewModel.init(city: city)
        }))
    }
}
