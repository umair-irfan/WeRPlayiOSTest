//
//  APIClient.swift
//  WeRPlayiOSTest
//
//  Created by Umair Irfan on 02/02/2022.
//

import Foundation

public protocol ApiClientProtocol {
    func request<T:Codable>(router: URLRequestConvertible, completionHandler: @escaping (Result<T,AppError>) -> Void)
}

public class APIClient {
    private let session = URLSession(configuration: .default)
    
    private func fetchData(request : URLRequest?, completion:@escaping (Result<Data,AppError>) -> Void) {
        session.configuration.waitsForConnectivity = true
        guard let url = request?.url else {
            let error = AppError.init(error: "Not a valid Url")
            completion(.failure(error))
            return
        }
        
        let task = session.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let data = data {
                completion(.success(data))
            } else if let error = error {
                completion(.failure(AppError.init(error: error.localizedDescription)))
            }
        }
        task.resume()
        
    }
}

extension APIClient: ApiClientProtocol {
    public func request<T:Codable>(router: URLRequestConvertible, completionHandler: @escaping (Result<T,AppError>) -> Void) {
        self.fetchData(request: router.urlRequest()) { result in
            switch result {
            case .success(let data):
                print(String(decoding: data, as: UTF8.self))
                do {
                    let decode = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(.success(decode))
                }catch let error{
                    completionHandler(.failure(AppError(error:error.localizedDescription)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
