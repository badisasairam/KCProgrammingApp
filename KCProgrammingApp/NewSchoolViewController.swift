//
//  NewSchoolViewController.swift
//  KCProgrammingApp
//
//  Created by student on 3/14/19.
//  Copyright © 2019 Badisa,Sairam. All rights reserved.
//

import UIKit

class NewSchoolViewController: UIViewController {
    
    @IBOutlet weak var NameTF: UITextField!
    @IBOutlet weak var coachTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func done(_ sender: Any) {
        if NameTF.text != "" , coachTF.text != ""{
            
            let school = School(name: NameTF.text!, coach: coachTF.text!, teams: [])
            
            Schools.shared.saveSchool(name: NameTF.text!, coach: coachTF.text!)
            
            self.dismiss(animated: true, completion: nil)
            
        }else{
            
            let alert = UIAlertController(title: "Warning",
                                          
                                          message: "You need to input all values",
                                          
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default,
                                          
                                          handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
    }

    
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
