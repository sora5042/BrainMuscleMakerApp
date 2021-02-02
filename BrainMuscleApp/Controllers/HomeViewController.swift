//
//  ViewController.swift
//  BrainMuscleApp
//
//  Created by 大谷空 on 2021/01/28.
//

import UIKit
import Pastel
import Lottie
import Firebase
import FirebaseFirestore

class HomeViewController: UIViewController, UINavigationControllerDelegate {
    
    let db = Firestore.firestore()
    
    var brainMuscleCount = Int()
    var bonzinCount = Int()
    var trashCount = Int()
    
    let brainMuscleDocId = "brainMuscle"
    let bonzinDocId = "bonzin"
    let trashDocId = "trash"
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var totalrecordButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        //        setupFirestore()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pastelAnimation()
    }
    
    private func setupView() {
        
        totalrecordButton.addTarget(self, action: #selector(tappedTotalRecordButton), for: .touchUpInside)
        resultButton.addTarget(self, action: #selector(tappedResultButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        imageButton.addTarget(self, action: #selector(tappedImageButton), for: .touchUpInside)
        
        imageButton.layer.borderWidth = 2
        imageButton.layer.borderColor = UIColor.rgb(red: 240, green: 240, blue: 240).cgColor
        resultButton.layer.cornerRadius = 12
        totalrecordButton.layer.cornerRadius = 12
        
        backButton.layer.borderWidth = 2
        backButton.layer.borderColor = UIColor.systemTeal.cgColor
        backButton.layer.cornerRadius = 12
        
        resultLabel.text = ""
        
        brainMuscleCount = UserDefaults.standard.object(forKey: "brainMuscleCount") as! Int
        bonzinCount = UserDefaults.standard.object(forKey: "bonzinCount") as! Int
        trashCount = UserDefaults.standard.object(forKey: "trashCount") as! Int
    }
    
//    private func setupFirestore() {
//
//        let brainMuscleDocData = ["brainMuscleCount": 0]
//
//        if db.collection("noukin").document(brainMuscleDocId).setData(brainMuscleDocData) != nil {
//            return
//
//        }
//
//        db.collection("noukin").document(brainMuscleDocId).setData(brainMuscleDocData) { (err) in
//
//            if let err = err {
//                print("Firestoreへの情報の保存に失敗しました。\(err)")
//                return
//            }
//            print("Firestoreへの情報の保存に成功しました。")
//        }
//
//        let bonzinDocData = ["bonzinCount": 0]
//
//        if db.collection("bonzin").document(bonzinDocId).setData(bonzinDocData) != nil {
//            return
//        }
//
//        db.collection("bonzin").document(bonzinDocId).setData(bonzinDocData) { (err) in
//
//            if let err = err {
//                print("Firestoreへの情報の保存に失敗しました。\(err)")
//                return
//            }
//            print("Firestoreへの情報の保存に成功しました。")
//        }
//
//        let trashDocData = ["trashCount": 0]
//
//        if db.collection("trash").document(trashDocId).setData(trashDocData) != nil {
//            return
//
//        }
//
//        db.collection("trash").document(trashDocId).setData(trashDocData) { (err) in
//
//            if let err = err {
//                print("Firestoreへの情報の保存に失敗しました。\(err)")
//                return
//            }
//            print("Firestoreへの情報の保存に成功しました。")
//        }
//    }
    
    @objc private func tappedResultButton() {
        
        if imageButton.imageView?.image == nil {
            return
        }
        
        let noukin = "脳筋！脳筋！脳筋！脳筋！"
        let bonzin = "残念ながらこの人は凡人です。無価値。"
        let gomi = "ゴミだ！！！"
        
        let array = [["text": noukin,"per": 3],["text": bonzin,"per": 80],["text": gomi,"per": 17]]
        
        var target = Int(arc4random_uniform(100))
        let result = array.reduce("") { (str, value) -> String in
            
            if !str.isEmpty {
                return str
            }
            
            if let val = value["per"] as? Int, target >= val {
                target -= val
                return str
            } else {
                
                return value["text"] as! String
            }
        }
        
        switch result {
        
        case noukin:
            brainShowAnimation()
            
            brainMuscleCount = brainMuscleCount + 1
            UserDefaults.standard.set(brainMuscleCount, forKey: "brainMuscleCount")
            let brainMuscleCountData = UserDefaults.standard.object(forKey: "brainMuscleCount") as? Int
            self.db.collection("noukin").document(brainMuscleDocId).updateData(["brainMuscleCount": brainMuscleCountData! ], completion: nil)
            
        case bonzin:
            bonzinShowAnimation()
            
            bonzinCount = bonzinCount + 1
            UserDefaults.standard.set(bonzinCount, forKey: "bonzinCount")
            let bonzinCountData = UserDefaults.standard.object(forKey: "bonzinCount") as? Int
            self.db.collection("bonzin").document(bonzinDocId).updateData(["bonzinCount": bonzinCountData!], completion: nil)
            
        case gomi:
            trashShowAnimation()
            
            trashCount = trashCount + 1
            UserDefaults.standard.set(trashCount, forKey: "trashCount")
            let trashCountData = UserDefaults.standard.object(forKey: "trashCount") as? Int
            self.db.collection("trash").document(trashDocId).updateData(["trashCount": trashCountData!], completion: nil)
            
        default:
            break
        }
        
        resultLabel.text = result
    }
    
    @objc private func tappedImageButton() {
        
        let checkModel = CheckModel()
        checkModel.showCheckPermission()
        showAlert()
    }
    
    @objc private func tappedBackButton() {
        
        let storyboard = UIStoryboard(name: "Title", bundle: nil)
        let titleViewController = storyboard.instantiateViewController(withIdentifier: "TitleViewController") as! TitleViewController
        titleViewController.modalTransitionStyle = .crossDissolve
        titleViewController.modalPresentationStyle = .fullScreen
        self.present(titleViewController, animated: true, completion: nil)
        
    }
    
    @objc private func tappedTotalRecordButton() {
        
        let storyboard = UIStoryboard(name: "TotalRecord", bundle: nil)
        let totalRecordViewController = storyboard.instantiateViewController(withIdentifier: "TotalRecordViewController") as! TotalRecordViewController
        totalRecordViewController.modalTransitionStyle = .flipHorizontal
        totalRecordViewController.modalPresentationStyle = .fullScreen
        self.present(totalRecordViewController, animated: true, completion: nil)
    }
}

extension HomeViewController {
    
    private func trashShowAnimation() {
        
        let animationView = AnimationView(name: "trash2")
        animationView.frame = CGRect(x: 0, y: 0, width: backView.bounds.width, height: backView.bounds.height)
        animationView.center = self.backView.center
        animationView.loopMode = .playOnce
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 1
        
        backView.addSubview(animationView)
        backView.bringSubviewToFront(animationView)
        
        animationView.play { finished in
            if finished {
                animationView.removeFromSuperview()
            }
        }
    }
    
    private func bonzinShowAnimation() {
        
        let animationView = AnimationView(name: "bonzin1")
        animationView.frame = CGRect(x: 0, y: 0, width: backView.bounds.width, height: backView.bounds.height)
        animationView.center = self.backView.center
        animationView.loopMode = .playOnce
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 1
        
        
        backView.addSubview(animationView)
        backView.bringSubviewToFront(animationView)
        animationView.play { finished in
            if finished {
                animationView.removeFromSuperview()
            }
        }
    }
    
    private func brainShowAnimation() {
        
        let animationView = AnimationView(name: "brain2")
        animationView.frame = CGRect(x: 0, y: 0, width: backView.bounds.width, height: backView.bounds.height)
        animationView.center = self.backView.center
        animationView.loopMode = .playOnce
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 1
        
        backView.addSubview(animationView)
        backView.bringSubviewToFront(animationView)
        
        animationView.play { finished in
            if finished {
                animationView.removeFromSuperview()
            }
        }
    }
    
    private func pastelAnimation() {
        
        let pastelView = PastelView(frame: view.bounds)
        
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        pastelView.animationDuration = 2.0
        
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

extension HomeViewController: UIImagePickerControllerDelegate {
    
    func doCamera() {
        
        let sourceType:UIImagePickerController.SourceType = .camera
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
    }
    
    func doAlbum() {
        
        let sourceType:UIImagePickerController.SourceType = .photoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editImage = info[.editedImage] as? UIImage {
            imageButton.setImage(editImage.withRenderingMode(.alwaysOriginal), for: .normal)
            
        } else if let originalImage = info[.originalImage] as? UIImage {
            imageButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        imageButton.setTitle("", for: .normal)
        imageButton.imageView?.contentMode = .scaleAspectFill
        imageButton.contentHorizontalAlignment = .fill
        imageButton.contentVerticalAlignment = .fill
        imageButton.clipsToBounds = true
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func showAlert(){
        
        let alertController = UIAlertController(title: "選択", message: "どちらを使用しますか?", preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "カメラ", style: .default) { (alert) in
            
            self.doCamera()
        }
        
        let action2 = UIAlertAction(title: "アルバム", style: .default) { (alert) in
            
            self.doAlbum()
        }
        
        let action3 = UIAlertAction(title: "キャンセル", style: .cancel)
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        self.present(alertController, animated: true, completion: nil)
        
    }
}
