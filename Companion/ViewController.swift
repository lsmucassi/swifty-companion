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
    
    @IBOutlet weak var usernameTextBox: UITextField!
    var auth = Auth()
    var jsonData: JSON?
    let dispatchGroup = DispatchGroup()
    
    
    @IBAction func getUser(_ sender: Any) {
       searchStudent()
    }
    
     func searchStudent(){
        auth.get_token()
        if usernameTextBox.text != "" {
            usernameTextBox.isEnabled = true
            let login = usernameTextBox.text?.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
            dispatchGroup.enter()
            auth.get_user(user: login!) { completion in
                self.jsonData = completion
                if self.jsonData == [:] {
                    self.createAlert(title: "Failure!", message: "Cannot fetch user.")
                } else {
                    self.performSegue(withIdentifier: "segue", sender: self)
                     self.dispatchGroup.leave()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: { (action) in
            self.usernameTextBox.text = ""
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}


