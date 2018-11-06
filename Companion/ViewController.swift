//
//  ViewController.swift
//  Companion
//
//  Created by William PHOKOMPE on 2018/10/26.
//  Copyright © 2018 William PHOKOMPE. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

//var name = "42"

class ViewController: UIViewController {
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var usernameTextBox: UITextField!
    var auth = Auth()
    var jsonData: JSON?
    let dispatchGroup = DispatchGroup()
    
     func searchStudent() {
        auth.get_token()
        
        if usernameTextBox.text != "" {
            usernameTextBox.isEnabled = true
            let login = usernameTextBox.text?.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
            dispatchGroup.enter()
            auth.get_user(user: login!) { completion in
                self.jsonData = completion
                self.dispatchGroup.leave()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.searchStudent()
        dispatchGroup.notify(queue: .main) {
            let secondViewController = segue.destination as! _2ViewController
            secondViewController.data = self.jsonData
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        auth.get_token()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


