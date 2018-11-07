//
//  42ViewController.swift
//  Companion
//
//  Created by William PHOKOMPE on 2018/10/29.
//  Copyright © 2018 William PHOKOMPE. All rights reserved.
//

import UIKit
import SwiftyJSON

class _2ViewController: UIViewController {
    
    @IBOutlet weak var skillTableView: UITableView!
    @IBOutlet weak var projectTableView: UITableView!
    @IBOutlet weak var actionIndicator: UIActivityIndicatorView!
    
    var skills: [Skill] = []
    var projects: [Project] = []
    var data: JSON!
    var dispatcGroup = DispatchGroup()
    
    func reload(after seconds: Int, completion: @escaping () -> Void) {
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            completion()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actionIndicator.startAnimating()
        skillTableView.delegate = self
        skillTableView.dataSource = self
        
        projectTableView.delegate = self
        projectTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func loadData() {
        dispatcGroup.enter()
        reload(after: 2) {
            if self.data != nil {
                self.data["cursus_users"][0]["skills"].array?.forEach({
                    (_skill) in
                    let skill = Skill(name: _skill["name"].stringValue, level: _skill["level"].floatValue, skillLevel: _skill["level"].stringValue)
                    self.skills.append(skill)
                })
                
                self.data["projects_users"].array?.forEach({ (_project) in
                    let project = Project(name: _project["project"]["slug"].stringValue, grade: _project["final_mark"].stringValue, valid: _project["validated?"].boolValue)
                    self.projects.append(project)
                    })
                
                self.actionIndicator.stopAnimating()
                self.actionIndicator.isHidden = true
                self.skillTableView.reloadData()
                self.projectTableView.reloadData()
                
                self.dispatcGroup.leave()
            }
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.loadData()
        dispatcGroup.notify(queue: .main) {
            let thirdViewController = segue.destination as! ProfileViewController
            thirdViewController.data = self.data
        }
    }
}

extension _2ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == skillTableView {
            return skills.count
        } else {
            return projects.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == skillTableView {
            let skill = skills[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SkillCell") as! SkillCell
            
            cell.setSkill(skill: skill.name, progress: skill.level - Float(Int(skill.level)), _skillLevel: skill.skillLevel)
            return cell
        } else {
            let project = projects[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell") as! ProjectCell
        
            cell.setProject(name: project.name, grade: project.grade, valid: project.valid)
            return cell
        }
    }
}
