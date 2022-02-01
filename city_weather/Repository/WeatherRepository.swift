//
//  WeatherRepository.swift
//  city_weather
//
//  Created by Alejandro Guerra, DSpot on 2/1/22.
//

import Foundation
import RxSwift

protocol WeatherRepositoryProtocol{
    
}

class WeatherRepository: WeatherRepositoryProtocol{
    private let provider: WeatherProviderProtocol
    
    init(provider: WeatherProviderProtocol){
        self.provider = provider
    }
}
