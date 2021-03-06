//
//  LocationWeatherViewControllerFactory.swift
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
    
    func locationDayInformationViewController(applicableDate: Date, locationName: String, woeid: Int, cwId: Int) -> BaseViewController {
        LocationDayViewController.init(arg: LocationDayVCArg.init(locationName: locationName, applicableDate: applicableDate, woeid: woeid, wsId: cwId))
    }
    
    func searchLocation(locationAdded: (() -> ())?) -> BaseViewController{
        SearchLocationViewController.init(locationAddedClosure: locationAdded)
    }
    
}
