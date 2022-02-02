//
//  CitiesInteractor.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 2/1/22.
//

import Foundation
import RxSwift

protocol CitiesInteractorProtocol{
    func requestCities()
}

class CitiesInteractor: CitiesInteractorProtocol{
    private let repository: WeatherRepositoryProtocol
    private let presenter: CitiesPresenterProtocol
    private let disposeBag = DisposeBag()
    
    init(repository: WeatherRepositoryProtocol, presenter: CitiesPresenterProtocol){
        self.repository = repository
        self.presenter = presenter
    }
    
    func requestCities(){
        presenter.networkState(state: .loading)
        repository.cities().subscribe { cityList in
            self.presenter.networkState(state: .success)
            self.presenter.loadCities(cityList: cityList)
        } onFailure: { error in
            self.presenter.networkState(state: .error)
            self.presenter.errorDetected(error: error) {
                self.requestCities()
            }
        }.disposed(by: disposeBag)
    }
}
