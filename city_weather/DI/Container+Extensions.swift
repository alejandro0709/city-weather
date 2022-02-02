//
//  Container+Extensions.swift
//  city_weather
//
//  Created by Alejandro Guerra, DSpot on 2/1/22.
//

import Foundation
import Swinject

extension Container{
    static let sharedContainer: Container = {
        let container = Container()
        
        container.register(WeatherProviderProtocol.self){ resolver in
            WeatherProvider.init(service: Service<MetalWeatherApi>())
        }.inObjectScope(.container)
        
        container.register(WeatherRepositoryProtocol.self){ resolver in
            WeatherRepository.init(provider: resolver.resolve(WeatherProviderProtocol.self)!)
        }.inObjectScope(.container)
        
        return container
    }()
}
