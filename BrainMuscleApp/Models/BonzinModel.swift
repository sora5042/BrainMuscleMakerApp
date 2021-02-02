//
//  bonzinModel.swift
//  BrainMuscleApp
//
//  Created by 大谷空 on 2021/02/02.
//

import Foundation

class BonzinModel {
    
    var bonzinCount: Int
    
    init(dic: [String: Any]) {
        
        self.bonzinCount = dic["bonzinCount"] as? Int ?? Int()
        
    }
}
