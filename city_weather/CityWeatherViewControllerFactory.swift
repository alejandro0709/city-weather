//
//  CityWeatherViewControllerFactory.swift
//  city_weather
//
//  Created by Alejandro Guerra, DSpot on 2/1/22.
//

import Foundation
import UIKit

class CityWeatherViewControllerFactory: ViewControllerFactory {
    func citiesViewController() -> UIViewController {
        ViewController()
    }
    
    func cityDetailsViewController(woeid: Int) -> UIViewController {
        ViewController()
    }
    
    func locationDayInformationViewController(applicableDate: Date) -> UIViewController {
        ViewController()
    }
    
    
}
