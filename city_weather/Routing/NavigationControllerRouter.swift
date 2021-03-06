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
    func navigateToDay(aplicableDate: Date, locationName: String, woeid: Int, cwId: Int)
    func navigateToSearchLocation(locationAddedClosure: (() -> ())?)
    func navigateBack()
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
    
    func navigateToDay(aplicableDate: Date, locationName: String, woeid: Int, cwId: Int){
        navigationController.pushViewController(factory.locationDayInformationViewController(applicableDate: aplicableDate, locationName: locationName, woeid: woeid, cwId: cwId), animated: true)
    }
    
    func navigateBack(){
        navigationController.popViewController(animated: true)
    }
    
    func navigateToSearchLocation(locationAddedClosure: (() -> ())?){
        navigationController.pushViewController(factory.searchLocation(locationAdded: locationAddedClosure), animated: true)
    }
    
}
