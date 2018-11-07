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
    
    @IBOutlet weak var skillLevel: UILabel!
    func setSkill(skill: String, progress: Float, _skillLevel: String) {
        skillLabel.text = skill
        skillLevel.text = _skillLevel
        skillProgressBar.progress = progress
    }
}
