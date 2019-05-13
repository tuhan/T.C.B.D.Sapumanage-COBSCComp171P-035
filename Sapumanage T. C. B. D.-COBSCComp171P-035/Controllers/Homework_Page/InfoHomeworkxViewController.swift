//
//  InfoHomeworkxViewController.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/13/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import UIKit

class InfoHomeworkxViewController: UINavigationController {

    var selectedHomework: Homework?
    
    @IBOutlet weak var homeworkTitle: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.homeworkTitle.text = "It Work"
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
