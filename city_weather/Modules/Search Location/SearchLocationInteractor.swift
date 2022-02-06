//
//  SearchLocationInteractor.swift
//  city_weather
//
//  Created by Alejandro Guerra, DSpot on 2/6/22.
//

import Foundation
import RxSwift

protocol SearchLocationInteractorProtocol{
    func searchLocation(query: String)
    func addLocation(woeid: Int, title: String)
}

class SearchLocationInteractor: SearchLocationInteractorProtocol{
    private let repository: WeatherRepositoryProtocol
    private let presenter: SearchLocationPresenterProtocol
    private let disposeBag = DisposeBag()
    
    init(repository: WeatherRepositoryProtocol, presenter: SearchLocationPresenterProtocol){
        self.repository = repository
        self.presenter = presenter
    }
    
    func searchLocation(query: String){
        presenter.networkState(state: .loading)
        repository.searchLocationByTitle(title: query).subscribe { locationList in
            self.presenter.networkState(state: .success)
            self.presenter.loadLocations(locationList: locationList)
        } onFailure: { error in
            self.presenter.networkState(state: .error)
            self.presenter.errorDetected(error: error) {
                self.searchLocation(query: query)
            }
        }.disposed(by: disposeBag)
    }
    
    func addLocation(woeid: Int, title: String){
        repository.addLocation(woeid: woeid, title: title).subscribe {
            self.presenter.locationSaved()
        } onError: { error in
            self.presenter.errorDetected(error: error) {
                self.addLocation(woeid: woeid, title: title)
            }
        }.disposed(by: disposeBag)
    }
}
