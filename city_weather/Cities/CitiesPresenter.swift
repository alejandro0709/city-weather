//
//  CitiesPresenter.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 2/1/22.
//

import Foundation
protocol CitiesPresenterProtocol{
    func setupDisplayer(viewController: CitiesDisplayerProtocol)
    func networkState(state: NetworkState)
    func errorDetected(error: Error, retryAction: (() ->())?)
    func loadCities(cityList: [City])
}

class CitiesPresenter: CitiesPresenterProtocol{
    private var viewController: CitiesDisplayerProtocol?
    
    func setupDisplayer(viewController: CitiesDisplayerProtocol){
        self.viewController = viewController
    }
    
    func networkState(state: NetworkState){
        viewController?.networkState(state: state)
    }
    
    func errorDetected(error: Error, retryAction: (() ->())?){
        
    }
    
    func loadCities(cityList: [City]){
        viewController?.loadCities(cityList: cityList.map({ city -> CityTableViewCellViewModel in
            CityTableViewCellViewModel.init(city: city)
        }))
    }
}
