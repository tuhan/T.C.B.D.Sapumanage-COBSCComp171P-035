//
//  PasswordResetViewController.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/12/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import UIKit
import Firebase

class PasswordResetViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var sendEmailButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendEmailButton.layer.cornerRadius = 10
        sendEmailButton.isHidden = true
        emailErrorLabel.text = "Please enter your Email Address"
        
        errorLabel.isHidden = true
        
        self.emailTextField.addTarget(self, action: #selector(usernameTextFeildChanged), for: .editingChanged)

        addKeyboardToolBarUsernameField()
        
    }
    
    // MARK: Sending Email to Reset Password
    @IBAction func sendEmailButtonClicked(_ sender: Any) {
        
        self.view.endEditing(true)
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { error in
            if error != nil {
                self.errorLabel.text = "Error Occured! Please check your email address and Try Again!"
                self.errorLabel.isHidden = false
            }
            else
            {
                AppSessionConnect.passwordResetMailSent = true
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: Validating Email
extension PasswordResetViewController: UITextFieldDelegate {
    
    @objc func usernameTextFeildChanged() {
        if self.emailTextField.text!.count > 0 && self.usernameRegexValidator(usernameValidator: emailTextField.text!) {
            UIView.animate(withDuration: 0.5){
                self.emailErrorLabel.isHidden = true
                self.sendEmailButton.isHidden = false
            }
        }else
        {
            self.emailErrorLabel.text = "Please enter a valid Email Address"
            self.emailErrorLabel.isHidden = false
            self.sendEmailButton.isHidden = true
        }
    }
    
    func usernameRegexValidator(usernameValidator: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: [.caseInsensitive])
        return regex.numberOfMatches(in: usernameValidator, options: [], range: NSMakeRange(0, usernameValidator.characters.count)) > 0
    }
}

// MARK: Setting up keyboard toolbars
extension PasswordResetViewController {
    
    func addKeyboardToolBarUsernameField() {
        let toolbarStatus = UIToolbar()
        toolbarStatus.sizeToFit()
        
        let clearButton = UIBarButtonItem(title: "Clear", style: .plain, target: nil, action: #selector(clearSelect))
        let doneStatusButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneSelect))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbarStatus.setItems([clearButton, spaceButton, doneStatusButton], animated: false)
        
        self.emailTextField.inputAccessoryView = toolbarStatus
    }
    
    @objc func doneSelect() {
        sendEmailButtonClicked (UIButton.self)
        self.view.endEditing (true)
    }
    
    @objc func clearSelect() {
        self.emailTextField.text = ""
    }
    
}
