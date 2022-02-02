//
//  CityWeatherViewControllerFactory.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 2/1/22.
//

import Foundation
import UIKit

class LocationWeatherViewControllerFactory: ViewControllerFactory {
    func locationsViewController() -> BaseViewController {
        LocationsListViewController()
    }
    
    func locationDetailsViewController(arguments: LocationDetailsArg) -> BaseViewController {
        LocationDetailsViewController.init(arg: arguments)
    }
    
    func locationDayInformationViewController(applicableDate: Date) -> BaseViewController {
        LocationsListViewController()
    }
    
    
}