//
//  AddNewHomeworkViewController.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/12/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import UIKit

class AddNewHomeworkViewController: UIViewController {

    @IBOutlet weak var homeworlScrollView: UIScrollView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var homeworkTitleTextField: UITextField!
    @IBOutlet weak var categorySwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For Description
        self.descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.descriptionTextView.layer.borderWidth = 1.0;
        self.descriptionTextView.layer.cornerRadius = 8;
        
        // For Homework Title
        self.homeworkTitleTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.homeworkTitleTextField.layer.borderWidth = 1.0;
        self.homeworkTitleTextField.layer.cornerRadius = 8;
        
        // Adding Keyboard Toolbars
        addKeyboardToolBarTitle()
        addKeyboardToolBarDesc()
        
        // Enabling Scroll View
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.homeworlScrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        homeworlScrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        homeworlScrollView.contentInset = contentInset
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        var homeworkType: String = ""
        var homeworkArray: [Homework] = []
        
        if categorySwitch.isOn {
            homeworkType = "Acadamic"
        }
        else
        {
            homeworkType = "Non-Acadamic"
        }
        
        let newHomework = Homework(json: ["homeworkTitle": homeworkTitleTextField.text, "homeworkCategory": homeworkType, "homeworkDesc": descriptionTextView.text])
        
        if UserDefaults.standard.object(forKey: "homeworkList") != nil {
            homeworkArray = NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.object(forKey: "homeworkList") as! Data) as! [Homework]
        }
        
        homeworkArray.append(newHomework)
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: homeworkArray)
        UserDefaults.standard.set(encodedData, forKey: "homeworkList")

        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension AddNewHomeworkViewController {
    
    // Toolbar for Homework Title
    func addKeyboardToolBarTitle() {
        let toolbarStatus = UIToolbar()
        toolbarStatus.sizeToFit()
        
        let clearButton = UIBarButtonItem(title: "Clear", style: .plain, target: nil, action: #selector(clearSelect))
        let doneStatusButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneSelect))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbarStatus.setItems([clearButton, spaceButton, doneStatusButton], animated: false)
        
        self.homeworkTitleTextField.inputAccessoryView = toolbarStatus
    }
    
    @objc func clearSelect() {
        self.homeworkTitleTextField.text = ""
    }
    
    @objc func doneSelect() {
        self.view.endEditing(true)
    }
    
    // Toolbar for HomeworkDesc
    func addKeyboardToolBarDesc() {
        let toolbarStatus = UIToolbar()
        toolbarStatus.sizeToFit()
        
        let clearButton = UIBarButtonItem(title: "Clear", style: .plain, target: nil, action: #selector(clearSelectDesc))
        
        let doneStatusButton = UIBarButtonItem(title: "Save", style: .done, target: nil, action: #selector(doneSelectDesc))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbarStatus.setItems([clearButton, spaceButton, doneStatusButton], animated: false)
        
        self.descriptionTextView.inputAccessoryView = toolbarStatus
    }
    
    @objc func clearSelectDesc() {
        self.descriptionTextView.text = ""
    }
    
    @objc func doneSelectDesc() {
        saveButtonClicked(UIButton())
        self.view.endEditing(true)
    }
    
}


