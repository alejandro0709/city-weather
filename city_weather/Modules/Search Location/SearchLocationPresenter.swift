//
//  SearchLocationPresenter.swift
//  city_weather
//
//  Created by Alejandro Guerra, DSpot on 2/6/22.
//

import Foundation

protocol SearchLocationPresenterProtocol: LocationsPresenterProtocol{
    func locationSaved()
    func setupDisplayer(viewController: SearchLocationDisplayerProtocol)
}

class SearchLocationPresenter: SearchLocationPresenterProtocol{
    private var viewController: SearchLocationDisplayerProtocol?
    
    func setupDisplayer(viewController: SearchLocationDisplayerProtocol) {
        self.viewController = viewController
    }
    
    func locationSaved() {
        viewController?.locationSaved()
    }
    
    func setupDisplayer(viewController: LocationsDisplayerProtocol) {}
    
    func loadLocations(locationList: [Location]) {
        viewController?.loadLocations(locationList: locationList.map({ location -> LocationTableViewCellViewModel in
            LocationTableViewCellViewModel.init(location: location)
        }))
    }
    
    func networkState(state: NetworkState) {
        viewController?.networkState(state: state)
    }
    
    func errorDetected(error: Error, retryAction: (() -> ())?) {
        viewController?.errorDetected(error: error, retryAction: retryAction)
    }
    
    
}
