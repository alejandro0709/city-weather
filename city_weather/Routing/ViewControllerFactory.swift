//
//  ViewControllerFactory.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 2/1/22.
//

import Foundation
import UIKit

protocol ViewControllerFactory{
    func locationsViewController() -> BaseViewController
    func locationDetailsViewController(arguments: LocationDetailsArg) -> BaseViewController
    func locationDayInformationViewController(applicableDate: Date, locationName: String, woeid: Int) -> BaseViewController
}
