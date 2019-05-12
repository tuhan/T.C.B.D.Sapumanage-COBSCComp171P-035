//
//  LoginAuthViewController.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/12/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import UIKit

class LoginAuthViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.layer.cornerRadius = 10;
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
    }
    
    @IBAction func forgotPasswordClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "PasswordResetSegue", sender: nil)
    }
 

}
