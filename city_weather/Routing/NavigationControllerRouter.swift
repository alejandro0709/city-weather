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
    func navigateToLocation(arg: LocationDetailsArg)
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
        navigationController.pushViewController(factory.locationsViewController(), animated: true)
    }
    
    func navigateToLocation(arg: LocationDetailsArg){
        navigationController.pushViewController(factory.locationDetailsViewController(arguments: arg), animated: true)
    }
    
    func navigateToDay(aplicableDate: Date){
        navigationController.pushViewController(factory.locationDayInformationViewController(applicableDate: aplicableDate), animated: true)
    }
    
}
