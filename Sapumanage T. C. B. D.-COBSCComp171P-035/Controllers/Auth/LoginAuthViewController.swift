//
//  LoginAuthViewController.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/12/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import UIKit
import Firebase

class LoginAuthViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var loginErrorLabel: UILabel!
    @IBOutlet weak var usernameErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.usernameTxt.addTarget(self, action: #selector(usernameTextFeildChanged), for: .editingChanged)
        self.passwordTxt.addTarget(self, action: #selector(passwordTextFieldChanged), for: .editingChanged)
        
        loginButton.layer.cornerRadius = 10;
        
        self.usernameErrorLabel.isHidden = true
        self.passwordErrorLabel.isHidden = true
        self.loginErrorLabel.isHidden = true
        
        self.passwordTxt.isHidden = true
        self.loginButton.isHidden = true
        
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
    
        Auth.auth().signIn(withEmail: usernameTxt.text!, password: passwordTxt.text!) { [weak self] user, error in
            guard let strongSelf = self else { return }
            if error != nil {
                self!.loginErrorLabel.isHidden = false
            }
            else
            {
                AppSessionConnect.activeSession = true
                self?.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func forgotPasswordClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "PasswordResetSegue", sender: nil)
    }
    
    func addToolBar () {
        
    }
    
}

extension LoginAuthViewController: UITextFieldDelegate {
    
    @objc func usernameTextFeildChanged() {
        if self.usernameTxt.text!.count > 0 && self.usernameRegexValidator(usernameValidator: usernameTxt.text!) {
            UIView.animate(withDuration: 0.5){
                self.usernameErrorLabel.isHidden = true
                self.passwordTxt.isHidden = false
            }
        }else
        {
            self.usernameErrorLabel.isHidden = false
            self.passwordTxt.isHidden = true
        }
    }
    
    @objc func passwordTextFieldChanged() {
        if self.usernameTxt.text!.count > 0 && self.passwordTxt.text!.count > 6 {
            UIView.animate(withDuration: 0.5){
                self.passwordErrorLabel.isHidden = true
                self.loginButton.isHidden = false
            }
        }else
        {
            self.passwordErrorLabel.isHidden = false
            self.loginButton.isHidden = true
        }

    }
    
    func usernameRegexValidator(usernameValidator: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: [.caseInsensitive])
        return regex.numberOfMatches(in: usernameValidator, options: [], range: NSMakeRange(0, usernameValidator.characters.count)) > 0
    }
    
    func passwordRegexValidator(passwordValidator: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{6,15}$", options: [.caseInsensitive])
        return regex.numberOfMatches(in: passwordValidator, options: [], range: NSMakeRange(0, passwordValidator.characters.count)) > 0
    }
    
}
