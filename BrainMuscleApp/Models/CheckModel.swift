//
//  CheckModel.swift
//  BrainMuscleApp
//
//  Created by 大谷空 on 2021/01/31.
//

import Foundation
import Photos

class CheckModel {
    
    func showCheckPermission(){
        PHPhotoLibrary.requestAuthorization { (status) in
            
            switch(status){
            
            case .authorized:
                print("許可されてますよ")
                
            case .denied:
                print("拒否")
                
            case .notDetermined:
                print("notDetermined")
                
            case .restricted:
                print("restricted")
                
            case .limited:
                print("limited")
            @unknown default: break
                
            }
            
        }
    }
}
