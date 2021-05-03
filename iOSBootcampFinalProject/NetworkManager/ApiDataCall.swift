//
//  apiDataCall.swift
//  iOSBootcampFinalProject
//
//  Created by TTN on 30/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation


class APICall {
    
    let session = URLSession.shared
    
    func request<T: Decodable>(_ url: URL, with method: HTTPMethod = .get, for dataType: T.Type , completion: @escaping (Result<T,Error>) -> Void )  {
    
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        let sessionTask = session.dataTask(with: request) { (data, response, error) in
            if let apiError = error {
                DispatchQueue.main.async {
                    completion(.failure(apiError))
                }
            } else if let apiData = data{
                do {
                    let parseData = try JSONDecoder().decode(dataType, from: apiData)
                    DispatchQueue.main.async {
                        completion(.success(parseData))
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(NSError.init(domain: "Some Error Occured", code: 1, userInfo: nil)))
                }
            }
        }
        sessionTask.resume()
    }
    
    func stopAllRequests() {
        session.invalidateAndCancel()
    }
    
}
//do {
//try JSONDecoder().decode(MyStruct.self, from: someData)
//} catch let error {
//completion(.failiure(error))
//}
