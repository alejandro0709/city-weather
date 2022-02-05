//
//  WeatherImageRepository.swift
//  city_weather
//
//  Created by Alejandro Guerra on 2/5/22.
//

import Foundation
import RxSwift

protocol WeatherImageRepositoryProtocol{
    func loadImage(by abbr: String, completion: @escaping ((_ imageData: Data) -> ()))
}

class WeatherImageRepository: WeatherImageRepositoryProtocol{
    private let provider: WeatherImageProviderProtocol
    private let disposeBag = DisposeBag()
    
    init(provider: WeatherImageProviderProtocol){
        self.provider = provider
    }
    
    func loadImage(by abbr: String, completion: @escaping ((_ imageData: Data) -> ())){
        provider.weatherImage(by: abbr)
            .subscribe { data in
                guard let data = data else { return }
                completion(data)
            } onFailure: { error in
                print(error)
            }.disposed(by: disposeBag)
    }
}
