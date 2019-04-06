//
//  NewTeamViewController.swift
//  KCProgrammingApp
//
//  Created by student on 3/14/19.
//  Copyright © 2019 Badisa,Sairam. All rights reserved.
//

import UIKit

class NewTeamViewController: UIViewController {
    
    @IBOutlet weak var teamNameLBL: UITextField!
    @IBOutlet weak var student0LBL: UITextField!
    @IBOutlet weak var student1LBL: UITextField!
    @IBOutlet weak var student2LBL: UITextField!
    
    
    @IBOutlet weak var newTeamNAV: UINavigationItem!
    
    var school:School!
    
    @IBAction func done(_ sender: Any) {
        let students:[String] = [student0LBL.text!, student1LBL.text!, student2LBL.text!]
        
        let team = Team(name: teamNameLBL.text!, students:[student0LBL.text!,student1LBL.text!,student2LBL.text!])
        
        
        if teamNameLBL.text != "" && (student0LBL.text != "" || student1LBL.text != "" || student2LBL.text != "")  {
            
            Schools.shared.saveTeamForSelectedSchool(school: school, team: team)
        
        self.dismiss(animated: true, completion: nil)
    }
    
        func cancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
        func viewDidLoad() {
        newTeamNAV.title = school.name
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
}
