//
//  ViewControllerFactory.swift
//  city_weather
//
//  Created by Alejandro Guerra, DSpot on 2/1/22.
//

import Foundation
import UIKit

protocol ViewControllerFactory{
    func citiesViewController() -> UIViewController
    func cityDetailsViewController(woeid: Int) -> UIViewController
    func locationDayInformationViewController(applicableDate: Date) -> UIViewController
}
