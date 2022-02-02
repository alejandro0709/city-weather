//
//  Container+Extensions.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 2/1/22.
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
        
        container.register(CitiesPresenterProtocol.self){ _ in
            CitiesPresenter.init()
        }.inObjectScope(.weak)
        
        container.register(CitiesInteractorProtocol.self){ resolver in
            CitiesInteractor.init(repository: resolver.resolve(WeatherRepositoryProtocol.self)!,
                                  presenter: resolver.resolve(CitiesPresenterProtocol.self)!)
        }.inObjectScope(.weak)
        
        return container
    }()
}
