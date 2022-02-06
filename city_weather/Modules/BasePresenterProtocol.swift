//
//  BasePresenterProtocol.swift
//  city_weather
//
//  Created by Alejandro Guerra on 2/5/22.
//

import Foundation

protocol BasePresenterProtocol{
    func networkState(state: NetworkState)
    func errorDetected(error: Error, retryAction: (() -> ())?)
}
