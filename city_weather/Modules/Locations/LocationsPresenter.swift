//
//  LocationsPresenter.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 2/1/22.
//

import Foundation
protocol LocationsPresenterProtocol: BasePresenterProtocol{
    func setupDisplayer(viewController: LocationsDisplayerProtocol)
    func loadLocations(locationList: [Location])
    func locationSaved()
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
        viewController?.errorDetected(error: error, retryAction: retryAction)
    }
    
    func loadLocations(locationList: [Location]){
        viewController?.loadLocations(locationList: locationList.map({ location -> LocationTableViewCellViewModel in
            LocationTableViewCellViewModel.init(location: location)
        }))
    }
    
    func locationSaved() {
        
    }
}
