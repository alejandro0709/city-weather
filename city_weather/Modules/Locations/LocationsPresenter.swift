//
//  LocationsPresenter.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 2/1/22.
//

import Foundation
protocol LocationsPresenterProtocol{
    func setupDisplayer(viewController: LocationsDisplayerProtocol)
    func networkState(state: NetworkState)
    func errorDetected(error: Error, retryAction: (() ->())?)
    func loadLocations(locationList: [Location])
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
    
    func loadLocations(locationList: [Location]){
        viewController?.loadLocations(locationList: locationList.map({ location -> LocationTableViewCellViewModel in
            LocationTableViewCellViewModel.init(location: location)
        }))
    }
}
