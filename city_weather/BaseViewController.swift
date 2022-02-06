//
//  BaseViewController.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 2/1/22.
//

import Foundation
import UIKit

open class BaseViewController: UIViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.accessibilityIdentifier = String(self.classForCoder.description())
        
        navigationController?.navigationBar.barTintColor = UIColor.black.withAlphaComponent(0.8)
        navigationController?.navigationBar.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            navigationController?.tabBarController?.tabBar.standardAppearance = appearance
            navigationController?.tabBarController?.tabBar.scrollEdgeAppearance = navigationController?.tabBarController?.tabBar.standardAppearance
            
            let navAppearance = UINavigationBarAppearance()
            navAppearance.configureWithOpaqueBackground()
            navAppearance.backgroundColor  = UIColor.black.withAlphaComponent(0.8)
            navAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 17)]
            navigationController?.navigationBar.standardAppearance = navAppearance
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        }
        
    }
}
