//
//  LocationDetailsInteractor.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 2/2/22.
//

import Foundation
import RxSwift

protocol LocationDetailsInteractorProtocol{
    func requestLocationData(woeid: Int)
}

class LocationDetailsInteractor: LocationDetailsInteractorProtocol{
    private let presenter: LocationDetailsPresenterProtocol
    private let repository: WeatherRepositoryProtocol
    private let disposeBag = DisposeBag()
    
    init(presenter: LocationDetailsPresenterProtocol, repository: WeatherRepositoryProtocol){
        self.presenter = presenter
        self.repository = repository
    }
    
    func requestLocationData(woeid: Int){
        presenter.networkState(state: .loading)
        repository.location(by: woeid, cacheDataCompletion: { itemLocation in
            self.presenter.locationDetails(location: itemLocation)
        }).subscribe { locationData in
            self.presenter.networkState(state: .success)
            self.presenter.locationDetails(location: locationData)
        } onFailure: { error in
            self.presenter.networkState(state: .error)
            self.presenter.errorDetected(error: error) {
                self.requestLocationData(woeid: woeid)
            }
        }.disposed(by: disposeBag)
    }
}
