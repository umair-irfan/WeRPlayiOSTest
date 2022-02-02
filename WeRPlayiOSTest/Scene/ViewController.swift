//
//  ViewController.swift
//  WeRPlayiOSTest
//
//  Created by Umair Irfan on 02/02/2022.
//

import UIKit

class ViewController: UIViewController {
    
    let apiService: BaseServiceProtocol = BaseService()
    private var breeds : [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiService.fetchBreeds { result in
            switch result {
            case .success(let breeds):
                self.breeds = breeds.getBreedsNameList()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

