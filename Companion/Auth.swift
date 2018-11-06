//
//  Auth.swift
//  Companion
//
//  Created by William PHOKOMPE on 2018/10/30.
//  Copyright © 2018 William PHOKOMPE. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class Auth: NSObject {
    var token = String()
    let url = "https://api.intra.42.fr/oauth/token"
    let config = [
        "grant_type" : "client_credentials",
        "client_id": "feaca4bc0a80a43c02c99c8e4997a955831f8e28c408fd7301bd457355b61894",
        "client_secret": "4c5c33331f09dc4cc2088753862a7f769aeb24cc34f83601a2b559e8c657f64e"]
    
    func get_token() {
        let verif = UserDefaults.standard.object(forKey: "token")
        if verif == nil {
            Alamofire.request(url, method: .post, parameters: config).validate().responseJSON {
                response in
                switch response.result {
                case .success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        self.token = json["access_token"].stringValue
                        UserDefaults.standard.set(json["access_token"].stringValue, forKey: "token")
                        print("NEW token:", self.token)
                        self.check_token()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            self.token = verif as! String
            print("SAME token:", self.token)
            check_token()
        }
    }
    
    private func check_token() {
        let check = NSURL(string: "https://api.intra.42.fr/oauth/token/info")
        let bearer = "Bearer " + self.token
        var request = URLRequest(url: check! as URL)
        request.httpMethod = "GET"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        Alamofire.request(request as URLRequestConvertible).validate().responseJSON {
            response in
            switch response.result {
            case .success(_):
                if let _ = response.result.value {
//                    let json = JSON(value)
                }
            case .failure(let error):
                print(error, "Error: Trying to get a new token...")
                UserDefaults.standard.removeObject(forKey: "token")
                self.get_token()
            }
        }
    }
    
    func get_user(user: String, completion: @escaping (JSON) -> Void) {
        let userUrl = NSURL(string: "https://api.intra.42.fr/v2/users/" + user)
        let bearer = "Bearer " + self.token
        let request = NSMutableURLRequest(url: userUrl! as URL)
        request.httpMethod = "GET"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        Alamofire.request(request as URLRequest).validate().responseJSON { response in
            switch response.result {
                case .success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        completion(json)
                    }
                case .failure:
                    completion([:])
                    print("Error: This login doesn't exists")
            }
        }
    }
}

