//
//  RetailCarsalesService.swift
//  carsales
//
//  Created by Charisse Co on 6/4/19.
//  Copyright © 2019 Charisse Co. All rights reserved.
//

import Foundation

class RetailCarsalesService: CarsalesService {
    
    private enum Url {
        static let base = "http://retailapi-v2.dev.carsales.com.au"
        static let retrieveList = "/stock/car/test/v1/listing"
    }

    private var parameters: String? {
        guard
            let plistPath = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: plistPath) as? [String: String],
            let username = dictionary["username"],
            let password = dictionary["password"]
            else { return nil }
        return String(format: "?username=%@&password=%@", username, password)
    }
    
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func retrieveListing(completion: @escaping (RetrieveListingResult) -> Void) {
        let requestString = Url.base + Url.retrieveList
        submitRequest(requestString) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedObject = try JSONDecoder().decode(CarListingPayload.self, from: data)
                    completion(.success(decodedObject.result))
                } catch let error {
                    completion(.failure(CarsalesServiceError.jsonParsingError(error)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func retrieveCarDetails(detailsUrl: String, completion: @escaping RetrieveCarDetailsCallback) {
        let requestString = Url.base + detailsUrl
        submitRequest(requestString) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedObject = try JSONDecoder().decode(CarDetailsPayload.self, from: data)
                    completion(.success(decodedObject.result))
                } catch let error {
                    completion(.failure(CarsalesServiceError.jsonParsingError(error)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func submitRequest(_ requestString: String, completion: @escaping (Result<Data, CarsalesServiceError>) -> Void) {
        guard
            let parameters = parameters,
            let dataURL = URL(string: requestString + parameters) else { return } // TODO: Error handling
        let request = URLRequest(url: dataURL)
        let task = session.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(CarsalesServiceError.networkError(error)))
                return
            }
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(CarsalesServiceError.dataNotFound))
            }
        }
        task.resume()
    }
}
