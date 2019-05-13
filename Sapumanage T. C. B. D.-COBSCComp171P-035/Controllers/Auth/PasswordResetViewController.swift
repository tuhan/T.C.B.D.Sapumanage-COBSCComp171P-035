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

        
    }
    
    

    @IBAction func sendEmailButtonClicked(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { error in
            if error != nil {
                self.errorLabel.text = "Error Occured! Please check your email address and Try Again!"
                self.errorLabel.isHidden = false
            }
            else
            {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

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
