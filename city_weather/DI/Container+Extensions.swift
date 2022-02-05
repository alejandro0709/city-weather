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
        
        container.register(WeatherImageProviderProtocol.self){ resolver in
            WeatherImageProvider.init(service: Service<MetalWeatherApi>())
        }.inObjectScope(.container)
        
        container.register(WeatherRepositoryProtocol.self){ resolver in
            WeatherRepository.init(provider: resolver.resolve(WeatherProviderProtocol.self)!)
        }.inObjectScope(.container)
        
        container.register(WeatherImageRepositoryProtocol.self){ resolver in
            WeatherImageRepository.init(provider: resolver.resolve(WeatherImageProviderProtocol.self)!)
        }.inObjectScope(.container)
        
        container.register(LocationsPresenterProtocol.self){ _ in
            LocationsPresenter.init()
        }.inObjectScope(.weak)
        
        container.register(LocationsInteractorProtocol.self){ resolver in
            LocationsInteractor.init(repository: resolver.resolve(WeatherRepositoryProtocol.self)!,
                                  presenter: resolver.resolve(LocationsPresenterProtocol.self)!)
        }.inObjectScope(.weak)
        
        container.register(LocationDetailsPresenterProtocol.self){ _ in
            LocationDetailsPresenter()
        }.inObjectScope(.weak)
        
        container.register(LocationDetailsInteractorProtocol.self){ resolver in
            LocationDetailsInteractor.init(presenter: resolver.resolve(LocationDetailsPresenterProtocol.self)!,
                                       repository: resolver.resolve(WeatherRepositoryProtocol.self)!)
        }
        
        return container
    }()
}
