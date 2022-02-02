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
    
    func cityDetailsViewController(woeid: Int) -> UIViewController {
        CityListViewController()
    }
    
    func locationDayInformationViewController(applicableDate: Date) -> UIViewController {
        CityListViewController()
    }
    
    
}
