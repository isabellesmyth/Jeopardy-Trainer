//
//  Categories.swift
//  JeopardyTrainer
//
//  Created by Isabelle Smyth on 12/8/19.
//  Copyright © 2019 Isabelle Smyth. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
//import UIKit

class Categories {
    
    var apiURL = "http://jservice.io/api/categories/"
    var categoryCount = 5
    var categoryArray: [Category] = []
    
    func getData(completed: @ escaping () -> ()) {
        var url = apiURL + "?count=" + String(categoryCount)
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print(json)
                let numberOfCategories = json.count
                for index in 0..<numberOfCategories {
                    let id = json[index]["id"].intValue
                    let title = json[index]["title"].stringValue
                    let cluesCount = json[index]["clues_count"].intValue
                    self.categoryArray.append(Category(id: id, title: title, cluesCount: cluesCount))
                   
                }
                print("category array is \(self.categoryArray[0].title)")
            case .failure(let error):
                print("error")
            }
            completed()
        }
       
        
    }

}

