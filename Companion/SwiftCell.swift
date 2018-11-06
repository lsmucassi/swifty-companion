//
//  SwiftCell.swift
//  Companion
//
//  Created by William PHOKOMPE on 2018/10/26.
//  Copyright © 2018 William PHOKOMPE. All rights reserved.
//

import UIKit

class SwiftCell: UITableViewCell {
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var skillProgressBar: UIProgressView!
    func setSkillCell(skill: String, progress: Float){
        skillLabel.text = skill
        skillProgressBar.progress = progress
    }
}
