//
//  WeatherImageProvider.swift
//  city_weather
//
//  Created by Alejandro Guerra on 2/5/22.
//

import Foundation
import RxSwift

protocol WeatherImageProviderProtocol{
    func weatherImage(by abbr: String) -> Single<Data?>
}

class WeatherImageProvider: WeatherImageProviderProtocol{
    private let service: Service<MetalWeatherApi>
    
    init(service: Service<MetalWeatherApi>){
        self.service = service
    }
    
    func weatherImage(by abbr: String) -> Single<Data?>{
        Single.create { observer in
            self.service.request(.image(name: abbr)) { result in
                switch result{
                case .success(data: let data):
                    observer(.success(data))
                case .failure(error: let error):
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}
