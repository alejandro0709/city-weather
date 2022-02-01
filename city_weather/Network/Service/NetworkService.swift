//
//  NetworkRouter.swift
//  city_weather
//
//  Created by Alejandro Guerra, 1/31/22.
//

import Foundation

public typealias NetworkServiceCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()
protocol NetworkService: AnyObject{
    associatedtype Request: TargetType
    
    func request(_ requestType: Request, completion: @escaping NetworkServiceCompletion)

}
