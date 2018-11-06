//
//  SkillCell.swift
//  Companion
//
//  Created by William PHOKOMPE on 2018/10/29.
//  Copyright © 2018 William PHOKOMPE. All rights reserved.
//

import UIKit

class SkillCell: UITableViewCell {
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var skillProgressBar: UIProgressView!
    
    func setSkill(skill: String, progress: Float) {
        skillLabel.text = skill
        skillProgressBar.progress = progress
    }
}
