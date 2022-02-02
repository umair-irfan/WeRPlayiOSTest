//
//  Breeds.swift
//  WeRPlayiOSTest
//
//  Created by Umair Irfan on 03/02/2022.
//

import Foundation

struct Breeds: Codable {
    let message: [String: [String]]
    let status: String
    
    func getBreedsNameList()-> [String] {
        var breedsList: [String] = Array()
        for item in self.message.enumerated() {
            //print("\(item.offset): \(item.element.key)")
            breedsList.append(item.element.key)
        }
        return breedsList
    }
}
