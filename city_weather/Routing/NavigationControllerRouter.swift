//
//  NavigationControllerRouter.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 2/1/22.
//

import Foundation
import UIKit

protocol NavigationControllerRouterProtocol{
    func startApp()
    func navigateToCity(arg: CityDetailsArg)
    func navigateToDay(aplicableDate: Date)
}

class NavigationControllerRouter: NavigationControllerRouterProtocol{
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(navigationController: UINavigationController, factory: ViewControllerFactory){
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func startApp() {
        navigationController.pushViewController(factory.citiesViewController(), animated: true)
    }
    
    func navigateToCity(arg: CityDetailsArg){
        navigationController.pushViewController(factory.cityDetailsViewController(arguments: arg), animated: true)
    }
    
    func navigateToDay(aplicableDate: Date){
        navigationController.pushViewController(factory.locationDayInformationViewController(applicableDate: aplicableDate), animated: true)
    }
    
}
