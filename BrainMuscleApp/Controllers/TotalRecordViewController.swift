//
//  TotalRecordViewController.swift
//  BrainMuscleApp
//
//  Created by 大谷空 on 2021/01/29.
//

import UIKit
import Pastel
import Firebase
import FirebaseFirestore

class TotalRecordViewController: UIViewController {
    
    private let db = Firestore.firestore()
    private var noukinModel = [NoukinModel]()
    private var bonzinModel = [BonzinModel]()
    private var trashModel = [TrashModel]()
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var brainMuscleCountLabel: UILabel!
    @IBOutlet weak var bonzinCountLabel: UILabel!
    @IBOutlet weak var trashCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        fetchNoukinFromFirestore()
        fetchBonzinFromFirestore()
        fetchTrashFromFirestore()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pastelAnimation()
        
    }
    
    private func setupView() {
        
        backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        backButton.layer.borderWidth = 2
        backButton.layer.borderColor = UIColor.systemTeal.cgColor
        backButton.layer.cornerRadius = 12
        
    }
    
    private func fetchNoukinFromFirestore() {
        
        db.collection("noukin").getDocuments { (snapShot, err) in
            
            if let err = err {
                print("Firestoreからの情報の取得に失敗しました\(err)")
                return
            }
            
            snapShot?.documents.forEach({ (snapShots) in
                
                let dic = snapShots.data()
                let noukinCount = NoukinModel.init(dic: dic)
                
                self.noukinModel.append(noukinCount)
                self.brainMuscleCountLabel.text = String(noukinCount.brainMuscleCount)
            })
        }
    }
    
    private func fetchBonzinFromFirestore() {
        
        db.collection("bonzin").getDocuments { (snapShot, err) in
            
            if let err = err {
                print("Firestoreからの情報の取得に失敗しました\(err)")
                return
            }
            
            snapShot?.documents.forEach({ (snapShots) in
                
                let dic = snapShots.data()
                let bonzinCount = BonzinModel.init(dic: dic)
                
                self.bonzinModel.append(bonzinCount)
                self.bonzinCountLabel.text = String(bonzinCount.bonzinCount)
            })
        }
    }
    
    private func fetchTrashFromFirestore() {
        
        db.collection("trash").getDocuments { (snapShot, err) in
            
            if let err = err {
                print("Firestoreからの情報の取得に失敗しました\(err)")
                return
            }
            
            snapShot?.documents.forEach({ (snapShots) in
                
                let dic = snapShots.data()
                let trashCount = TrashModel.init(dic: dic)
                
                self.trashModel.append(trashCount)
                self.trashCountLabel.text = String(trashCount.trashCount)
                
            })
        }
    }
    
    @objc private func tappedBackButton() {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    private func pastelAnimation() {
        
        let pastelView = PastelView(frame: view.bounds)
        
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        pastelView.animationDuration = 3.0
        
        pastelView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
                              UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
                              UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
                              UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)])
        
        pastelView.startAnimation()
        view.insertSubview(pastelView, at: 0)
        
    }
}
