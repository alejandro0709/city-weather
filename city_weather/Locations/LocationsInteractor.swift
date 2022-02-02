//
//  CitiesInteractor.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 2/1/22.
//

import Foundation
import RxSwift

protocol LocationsInteractorProtocol{
    func requestCities()
}

class LocationsInteractor: LocationsInteractorProtocol{
    private let repository: WeatherRepositoryProtocol
    private let presenter: LocationsPresenterProtocol
    private let disposeBag = DisposeBag()
    
    init(repository: WeatherRepositoryProtocol, presenter: LocationsPresenterProtocol){
        self.repository = repository
        self.presenter = presenter
    }
    
    func requestCities(){
        presenter.networkState(state: .loading)
        repository.cities().subscribe { list in
            self.presenter.networkState(state: .success)
            self.presenter.loadLocations(locationList: list)
        } onFailure: { error in
            self.presenter.networkState(state: .error)
            self.presenter.errorDetected(error: error) {
                self.requestCities()
            }
        }.disposed(by: disposeBag)
    }
}
