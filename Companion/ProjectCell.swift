//
//  ProjectCell.swift
//  Companion
//
//  Created by William PHOKOMPE on 2018/11/05.
//  Copyright © 2018 William PHOKOMPE. All rights reserved.
//

import UIKit

class ProjectCell: UITableViewCell {
    
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var projectGrade: UILabel!
    
    func setProject(name: String, grade: String, valid: Bool) {
        projectName.text = name
        projectGrade.text = grade + "%"
        
        if valid == false {
            projectGrade.textColor = UIColor(displayP3Red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        } else {
            projectGrade.textColor = UIColor(displayP3Red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
        }
    }
}
