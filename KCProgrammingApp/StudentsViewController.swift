//
//  StudentsViewController.swift
//  KCProgrammingApp
//
//  Created by student on 3/14/19.
//  Copyright © 2019 Badisa,Sairam. All rights reserved.
//

import UIKit

class StudentsViewController: UIViewController {
    
    @IBOutlet weak var stud0LBL: UILabel!
    @IBOutlet weak var stud1LBL: UILabel!
    @IBOutlet weak var stud2LBL: UILabel!
    
    @IBOutlet weak var studNAV: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var students:Team!
    
    override func viewWillAppear(_ animated: Bool) {
        studNAV.title = students.name
        stud0LBL.text = students.students[0]
        stud1LBL.text = students.students[1]
        stud2LBL.text = students.students[2]
    }
}

