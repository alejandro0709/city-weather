//
//  LocationDayViewController.swift
//  city_weather
//
//  Created by Alejandro Guerra on 2/5/22.
//

import Foundation
import UIKit
import Swinject

class LocationDayViewController: BaseDayForecastViewController{
    private var arg: LocationDayVCArg!
    private let interactor = Container.sharedContainer.resolve(LocationDayInteractorProtocol.self)!
    
    convenience init(arg: LocationDayVCArg) {
        self.init()
        self.arg = arg
        let presenter = Container.sharedContainer.resolve(LocationDayPresenterProtocol.self)!
        presenter.setupDisplayer(viewcontroller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "\(arg.locationName) - \(arg.applicableDate.prettyDate())"
        interactor.requestForecastData(woeid: arg.woeid, applicableDate: arg.applicableDate)
    }
}

struct LocationDayVCArg{
    let locationName: String
    let applicableDate: Date
    let woeid: Int
}
