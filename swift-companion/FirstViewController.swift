//
//  FirstViewController.swift
//  swift-companion
//
//  Created by Linda MUCASSI on 2018/10/19.
//  Copyright © 2018 Linda MUCASSI. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    /* Properties */
//    @IBOutlet weak var searchTextField: UISearchBar!
    @IBOutlet weak var seach: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(seach.text)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let destination = segue.destination as? ViewController
            print(seach.text!)
            destination?.userID = seach.text!
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
