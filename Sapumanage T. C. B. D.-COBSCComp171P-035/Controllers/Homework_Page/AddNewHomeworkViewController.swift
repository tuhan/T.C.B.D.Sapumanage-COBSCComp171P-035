//
//  AddNewHomeworkViewController.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/12/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import UIKit

class AddNewHomeworkViewController: UIViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var homeworkTitleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //For Description
        self.descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.descriptionTextView.layer.borderWidth = 1.0;
        self.descriptionTextView.layer.cornerRadius = 8;
        
        //For Homework Title
        self.homeworkTitleTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.homeworkTitleTextField.layer.borderWidth = 1.0;
        self.homeworkTitleTextField.layer.cornerRadius = 8;
        
    }
    

    @IBAction func saveButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
