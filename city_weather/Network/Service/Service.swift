//
//  Router.swift
//  city_weather
//
//  Created by Alejandro Guerra, 1/31/22.
//

import Foundation

class Service<Request: TargetType>: NetworkService{
    private var task: URLSessionTask?
    
    func request(_ targetType: Request, completion: @escaping NetworkServiceCompletion) {
        let urlSession = URLSession.shared
        do {
            let request = try buildRequest(from: targetType)
            task = urlSession.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        
        task?.resume()
    }
    
    private func buildRequest(from targetType: TargetType) throws -> URLRequest{
        var request = URLRequest.init(url: targetType.baseURL.appendingPathComponent(targetType.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        request.httpMethod = targetType.method.rawValue
        
        do {
            switch targetType.task{
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(body: let body, urlQuery: let urlQuery):
                try configureParameters(bodyParameters: body, urlParameters: urlQuery, request: &request)
            case .requestParametersWithHeaders(body: let body, urlQuery: let urlQuery, headers: let headers):
                addHeaders(headers, request: &request)
                try configureParameters(bodyParameters: body, urlParameters: urlQuery, request: &request)
            }
            
            return request
        }catch {
            throw error
        }
    }
    
    private func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoded.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    private func addHeaders(_ headers: HTTPHeaders?, request: inout URLRequest){
        guard let headers = headers else {
            return
        }
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    
}
