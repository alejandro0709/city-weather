//
//  ViewController.swift
//  city_weather
//
//  Created by Alejandro Guerra, 1/31/22.
//

import UIKit
import Swinject

class ViewController: UIViewController {

    private let router: NavigationControllerRouterProtocol? = Container.sharedContainer.resolve(NavigationControllerRouterProtocol.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }


}

