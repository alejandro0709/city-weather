//
//  ViewControllerFactory.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 2/1/22.
//

import Foundation
import UIKit

protocol ViewControllerFactory{
    func citiesViewController() -> UIViewController
    func cityDetailsViewController(arguments: CityDetailsArg) -> UIViewController
    func locationDayInformationViewController(applicableDate: Date) -> UIViewController
}
