//
//  CountModel.swift
//  BrainMuscleApp
//
//  Created by 大谷空 on 2021/02/01.
//

import Foundation

class NoukinModel {
    
    let brainMuscleCount: Int
    
    
    init(dic: [String: Any]) {
        
        self.brainMuscleCount = dic["brainMuscleCount"] as? Int ?? Int()
        
    }
}
