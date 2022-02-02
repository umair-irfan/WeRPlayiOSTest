//
//  AppError.swift
//  WeRPlayiOSTest
//
//  Created by Umair Irfan on 03/02/2022.
//

import Foundation

public struct AppError: Codable,Error {
    let error : String
    
    static func generalError() -> AppError{
        return AppError(error: "some thing went wrong")
    }
}

extension AppError {
    private enum CodingKeys: String, CodingKey {
        case error = "Error"
    }
}
