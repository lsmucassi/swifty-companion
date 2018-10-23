//
//  ViewController.swift
//  swift-companion
//
//  Created by Linda MUCASSI on 2018/10/19.
//  Copyright © 2018 Linda MUCASSI. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    
    let UID = "feaca4bc0a80a43c02c99c8e4997a955831f8e28c408fd7301bd457355b61894"
    let SECRET = "4c5c33331f09dc4cc2088753862a7f769aeb24cc34f83601a2b559e8c657f64e"
    var sessionToken = ""
    
    var userID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let BEARER = ((UID + ":" + SECRET).data(using: String.Encoding.utf8, allowLossyConversion: true))!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        
        guard let url = URL(string: "https://api.intra.42.fr/oauth/token") else {return}
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            
//            if let response = response {
////                print(response)
//            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    if let token = json["access_token"] {
//                        print(token)
                        self.sessionToken = token as! String
                        _ = self.getUserInfo()
                    }
                } catch {
                    print(error)
                }
            }
        })
        task.resume()
    }
    
    func getUserInfo() {
        print("Started connection")
        let authEndPoint: String = "https://api.intra.42.fr/v2/users/lmucassi"
        print(self.userID)
        let url = URL(string: authEndPoint)
        var request = URLRequest(url: url!)
        print(self.sessionToken)
        request.setValue("Bearer \(self.sessionToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let requestGET = session.dataTask(with: request) { (data, response, error) in
            //print(data!)
            if let data = data {
                do {
                    let json = JSON(data)
                    print(json)
                    print("Empty")
                }
                catch {
                    print(error)
                }
            }
        }
        requestGET.resume()
    }
}

