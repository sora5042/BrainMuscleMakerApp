//
//  TrashModel.swift
//  BrainMuscleApp
//
//  Created by 大谷空 on 2021/02/02.
//

import Foundation

class TrashModel {
    
    var trashCount: Int
    
    init(dic: [String: Any]) {
        
        self.trashCount = dic["trashCount"] as? Int ?? Int()
        
    }
}
