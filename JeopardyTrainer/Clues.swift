//
//  Clues.swift
//  JeopardyTrainer
//
//  Created by Isabelle Smyth on 12/8/19.
//  Copyright © 2019 Isabelle Smyth. All rights reserved.
//

import Foundation

import UIKit
import Alamofire
import SwiftyJSON
class Clues {
    var id: Int = 0
    var clueCount: Int = 0
    var apiURL = "http://jservice.io/api/category/?id="
    var clueArray: [Clue] = []
  
    
    func getData(completed: @escaping () -> ()) {
        
        let url = apiURL + String(id)
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print(json)
                let numberOfClues = json["clues"].count
                for index in 0..<numberOfClues {
                     let clue = Clue()
                     clue.question = json["clues"][index]["question"].stringValue
                     clue.answer = json["clues"][index]["answer"].stringValue
                     clue.categoryID = json["clues"][index]["category_id"].intValue
                     clue.value = json["clues"][index]["value"].intValue
                     clue.clueID = json["clues"][index]["id"].intValue
                    //print(C.question)
                    self.clueArray.append(clue)
                }
                 print("clues array is \(self.clueArray[0].question)")
            case .failure(let error):
                print("error")
            }
            completed()
        }
}

}
