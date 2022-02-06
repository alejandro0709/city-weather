//
//  UIImageView+LoadImage.swift
//  city_weather
//
//  Created by Alejandro Guerra on 2/5/22.
//

import Foundation
import UIKit
import Swinject

extension UIImageView{
    
    func weatherImageByAbbr(abbr: String){
        let repository = Container.sharedContainer.resolve(WeatherImageRepositoryProtocol.self)!
        repository.loadImage(by: abbr) {[weak self] imageData in
            DispatchQueue.main.async {
                self?.image = UIImage.init(data: imageData)
            }
        }
    }
}
