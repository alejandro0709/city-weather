//
//  WeatherImageRepository.swift
//  city_weather
//
//  Created by Alejandro Guerra on 2/5/22.
//

import Foundation
import RxSwift

protocol WeatherImageRepositoryProtocol{
    func loadImage(by abbr: String, completion: @escaping ((_ imageData: Data) -> ()))
}

class WeatherImageRepository: WeatherImageRepositoryProtocol{
    private let provider: WeatherImageProviderProtocol
    private let cache: ImageCacheProtocol
    private let disposeBag = DisposeBag()
    
    init(provider: WeatherImageProviderProtocol, cache: ImageCacheProtocol){
        self.provider = provider
        self.cache = cache
    }
    
    func loadImage(by abbr: String, completion: @escaping ((_ imageData: Data) -> ())){
        if let imageData = cache.getImageData(by: abbr){
            completion(imageData)
            return
        }
        
        provider.weatherImage(by: abbr)
            .do(onSuccess:{[weak self] imageData in
                guard let imageData = imageData else { return }
                completion(imageData)
                self?.cache.saveImage(abbr: abbr, imageData: imageData)
            }).subscribe().disposed(by: disposeBag)
    }
}
