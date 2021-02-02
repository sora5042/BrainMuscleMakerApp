//
//  TitleViewController.swift
//  BrainMuscleApp
//
//  Created by 大谷空 on 2021/01/28.
//

import UIKit
import Pastel

class TitleViewController: UIViewController {
    
    @IBOutlet weak var brainMuscleLabel: UILabel!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pastelAnimation()
    }
    
    private func setupView() {
        
        startButton.addTarget(self, action: #selector(tappedStartButton), for: .touchUpInside)
        startButton.layer.borderWidth = 2.5
        startButton.layer.borderColor = UIColor.systemTeal.cgColor
        startButton.layer.cornerRadius = 12
    }
    
    @objc private func tappedStartButton() {
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        homeViewController.modalTransitionStyle = .crossDissolve
        homeViewController.modalPresentationStyle = .fullScreen
        self.present(homeViewController, animated: true, completion: nil)
        
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
