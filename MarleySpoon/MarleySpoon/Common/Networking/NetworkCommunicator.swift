//
//  NetworkCommunicator.swift
//  MarleySpoon
//
//  Created by Gagan Vishal on 2020/01/25.
//  Copyright © 2020 Gagan Vishal. All rights reserved.
//

import Foundation

protocol Services {
    func fetchRecipeList<T: Decodable>(value: T.Type, completionHandler: @escaping (Result<T, APIError>) -> Void)
}

struct NetworkCommunicator: Services {
    /// URLSession Object
    fileprivate var session: URLSession = URLSession(configuration: .default)
    ///CompletionHandler
    fileprivate typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    /// Decode Obbject
    /// - Parameters:
    ///   - request: URLRequest object
    ///   - decodingType: decodable type
    ///   - completion: CompletionHandler with Decodable and APIError
    fileprivate func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed(description: error.debugDescription))
                return
            }
            //check for status code and whethere Data is avaibaleor not from serveer
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let genericModel = try decoder.decode(decodingType, from: data)
                        completion(genericModel, nil)
                    } catch let error {
                        print(error)
                        completion(nil, .jsonConversionFailure(description: error.localizedDescription))
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful(description: "status code = \(httpResponse.statusCode)"))
            }
        }
        return task
    }
    
    //MARK:- Make request and get Decodable Object
    fileprivate func fetch<T: Decodable>(with router: APIRouter, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        let request = router.asRequest()
        let task = decodingTask(with: request, decodingType: T.self) { (json , error) in
            ///change to main queue
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
        task.resume()
    }
    
    //MARK:- Fetch requested items
    fileprivate func fetchRequestedItems<T: Decodable>(router: APIRouter, completionHandler: @escaping (Result<T, APIError>) -> Void) {
        self.fetch(with: router, decode: { json -> T? in
            guard let resource = json as? T else { return nil }
            return resource
        }, completion: completionHandler)
    }
    
    //MARK:- Fetch RecipeList
    /// Fetch RecipeList from server
    /// - Parameters:
    ///   - value: Type of Decodable
    ///   - completionHandler: Completion Handler with type Result<T, APIError>
    func fetchRecipeList<T: Decodable>(value: T.Type, completionHandler: @escaping (Result<T, APIError>) -> Void) {
        self.fetchRequestedItems(router: APIRouter.recipeList, completionHandler: completionHandler)
    }
}
