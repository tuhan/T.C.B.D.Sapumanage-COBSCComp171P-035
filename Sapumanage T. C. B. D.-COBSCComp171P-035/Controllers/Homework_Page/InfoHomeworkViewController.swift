//
//  InfoHomeworkViewController.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/13/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import UIKit

class InfoHomeworkViewController: UIViewController {

    
    @IBOutlet weak var homeworkTitleTextField: UITextField!
    @IBOutlet weak var homeworkDescription: UITextView!
    @IBOutlet weak var homeworkCategorySwitch: UISwitch!
    
    var selectedHomework: Homework?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.homeworkTitleTextField.text = selectedHomework?.homeworkTitle
        self.homeworkDescription.text = selectedHomework?.homeworkDesc
        
        
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
