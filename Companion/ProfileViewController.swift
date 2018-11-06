//
//  ProfileViewController.swift
//  Companion
//
//  Created by William PHOKOMPE on 2018/10/29.
//  Copyright © 2018 William PHOKOMPE. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var correctionLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var progressLevel: UIProgressView!
    @IBOutlet weak var userImge: UIImageView!
    
    var data: JSON = JSON()
    var user: User!
    func execute(after seconds: Int, completion: @escaping () -> Void) {
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            completion()
        }
    }
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        nameLabel.text = ""
        phoneLabel.text = ""
        walletLabel.text = ""
        correctionLabel.text = ""
        levelLabel.text = ""
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        activity.startAnimating()
        
        
        execute(after: 3) {
            if self.data["image_url"].url != nil || self.data["cursus_users"][0]["level"].stringValue != "" {
                self.activity.isHidden = true
                self.activity.stopAnimating()
            } else {
                self.performSegue(withIdentifier: "42Segue", sender: self)
            }
            self.user = User(
                username: self.data["login"].stringValue,
                phone: self.data["phone"].stringValue,
                wallet: self.data["wallet"].stringValue,
                correction: self.data["correction_point"].stringValue,
                level: self.data["cursus_users"][0]["level"].floatValue,
                image: self.data["image_url"].url!
            )
            
            self.nameLabel.text = self.user.username
            self.phoneLabel.text = "Phone: " + self.user.phone
            self.walletLabel.text = "Wallet: " + self.user.wallet
            self.correctionLabel.text = "Correction: " + self.user.correction
            self.levelLabel.text = "Level: \(self.user.level)"
            self.progressLevel.progress = (self.user.level - Float(Int(self.user.level)))
            
            do {
                let data = try Data(contentsOf: self.user.image)
                self.userImge.image = UIImage(data: data)
            } catch let err {
                print("Error: \(err.localizedDescription)")
            }
            self.userImge.layer.borderWidth = 2
            self.userImge.layer.borderColor = UIColor.black.cgColor
            self.userImge.layer.cornerRadius = 40
            self.userImge.clipsToBounds = true
        }
    }
}
