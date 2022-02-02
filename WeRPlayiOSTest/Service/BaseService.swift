//
//  BaseService.swift
//  WeRPlayiOSTest
//
//  Created by Umair Irfan on 03/02/2022.
//

import Foundation

protocol BaseServiceProtocol {
    func fetchBreeds(completion: @escaping(Result<Breeds,AppError>) -> Void)
}

class BaseService: BaseServiceProtocol {
    
    private let apiManager: ApiClientProtocol = APIClient()
    
    func fetchBreeds(completion: @escaping (Result<Breeds, AppError>) -> Void) {
        let router = Router<Any>.getDogListing
        apiManager.request(router: router) { (result:Result<Breeds, AppError>) in
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        }
    }
    
    
}




