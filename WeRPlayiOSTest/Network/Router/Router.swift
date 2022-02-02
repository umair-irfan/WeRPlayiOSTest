//
//  Router.swift
//  WeRPlayiOSTest
//
//  Created by Umair Irfan on 02/02/2022.
//

import Foundation

struct TestingDomain {
    static var host = "dog.ceo"
}

public protocol URLRequestConvertible {
    func urlRequest()  -> URLRequest?
}

enum Router<T>: URLRequestConvertible {

    case getDogListing
    case getBreedDetails(T)
    
    private var scheme: String {
         switch self {
         case .getDogListing, .getBreedDetails:
             return "https"
         }
     }
    
    private var host: String {
         switch self {
         case .getDogListing, .getBreedDetails:
             return TestingDomain.host
         }
     }
     private var path: String {
         switch self {
         case .getDogListing:
             return "/api/breeds/list/all"
         case .getBreedDetails(let params):
             let request = params as! BreedDetailsRequest
             return  "/breed/\(request.breedName)/images"
         }
     }
    
    private var method: String {
         switch self {
         case .getDogListing, .getBreedDetails:
             return "GET"
         }
     }
    
    
    private var queryParameters: [URLQueryItem]? {
        switch self {
//        case .getBreedDetails(let params):
//            let request = params as! BreedDetailsRequest
//            return [URLQueryItem(name: "q", value: request.breedName)]
        default:
            return nil
        }
    }
    
    
    func urlRequest() -> URLRequest? {
        
        
        var components = URLComponents()
        components.queryItems = queryParameters
        
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path
        
        guard let url = components.url else {
            assert(true,"url not formed")
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method
        
        return urlRequest
    }
}
