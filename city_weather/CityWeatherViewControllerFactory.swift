//
//  CityWeatherViewControllerFactory.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 2/1/22.
//

import Foundation
import UIKit

class CityWeatherViewControllerFactory: ViewControllerFactory {
    func citiesViewController() -> UIViewController {
        CityListViewController()
    }
    
    func cityDetailsViewController(arguments: CityDetailsArg) -> UIViewController {
        LocationDetailsViewController.init(arg: arguments)
    }
    
    func locationDayInformationViewController(applicableDate: Date) -> UIViewController {
        CityListViewController()
    }
    
    
}
