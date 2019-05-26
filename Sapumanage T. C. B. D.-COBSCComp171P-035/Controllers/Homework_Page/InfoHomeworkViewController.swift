//
//  InfoHomeworkViewController.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/13/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import UIKit

class InfoHomeworkViewController: UIViewController {

    
    @IBOutlet weak var homeworkInfoScrollView: UIScrollView!
    @IBOutlet weak var homeworkTitleTextField: UITextField!
    @IBOutlet weak var homeworkDescription: UITextView!
    @IBOutlet weak var homeworkCategorySwitch: UISwitch!

    var selectedHomeworkIndex: Int?
    var homeworkArray = NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.object(forKey: "homeworkList") as! Data) as! [Homework]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Enabling Scroll View
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        // For Description
        self.homeworkDescription.layer.borderColor = UIColor.lightGray.cgColor
        self.homeworkDescription.layer.borderWidth = 1.0;
        self.homeworkDescription.layer.cornerRadius = 8;
        
        // For Homework Title
        self.homeworkTitleTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.homeworkTitleTextField.layer.borderWidth = 1.0;
        self.homeworkTitleTextField.layer.cornerRadius = 8;
        
        // Retreiving particular homework
        var selectedHomework = homeworkArray [selectedHomeworkIndex!]
        self.homeworkTitleTextField.text = selectedHomework.homeworkTitle
        self.homeworkDescription.text = selectedHomework.homeworkDesc
        
        
        // Setting Switch Value
        if selectedHomework.homeworkCategory == "Acadamic"
        {
            homeworkCategorySwitch.setOn(true, animated: true)
        }
        else
        {
            homeworkCategorySwitch.setOn(false, animated: true)
        }
        
        // Setting up keyboard Toolbars
        addKeyboardToolBarTitle()
        addKeyboardToolBarDesc()
        
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.homeworkInfoScrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        homeworkInfoScrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        homeworkInfoScrollView.contentInset = contentInset
    }
    
    @IBAction func saveInfoButtonClicked(_ sender: Any) {
        
        var homeworkType: String = ""
        
        if homeworkCategorySwitch.isOn {
            homeworkType = "Acadamic"
        }
        else
        {
            homeworkType = "Non-Acadamic"
        }
        
        let updatedHomework = Homework(json: ["homeworkTitle": homeworkTitleTextField.text, "homeworkCategory": homeworkType, "homeworkDesc": homeworkDescription.text])
        
        
        homeworkArray[selectedHomeworkIndex!] = updatedHomework
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: homeworkArray)
        UserDefaults.standard.set(encodedData, forKey: "homeworkList")
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func deleteNoteClicked(_ sender: Any) {
        homeworkArray.remove(at: selectedHomeworkIndex!)
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: homeworkArray)
        UserDefaults.standard.set(encodedData, forKey: "homeworkList")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension InfoHomeworkViewController {
    
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
        
        self.homeworkDescription.inputAccessoryView = toolbarStatus
    }
    
    @objc func clearSelectDesc() {
        self.homeworkDescription.text = ""
    }
    
    @objc func doneSelectDesc() {
        saveInfoButtonClicked(UIButton())
        self.view.endEditing(true)
    }
    
}
