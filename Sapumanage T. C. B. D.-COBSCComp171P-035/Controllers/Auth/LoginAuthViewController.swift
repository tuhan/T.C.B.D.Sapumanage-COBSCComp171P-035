//
//  LoginAuthViewController.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/12/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import FacebookLogin
import FacebookCore
import Firebase
import FacebookShare
import UIKit

class LoginAuthViewController: UIViewController {

    @IBOutlet weak var activityIndicatorView: UIView!
    @IBOutlet weak var activityIndicatorIcon: UIActivityIndicatorView!
    
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var loginErrorLabel: UILabel!
    @IBOutlet weak var usernameErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    @IBOutlet weak var facebookLoginView: UIView!
    @IBOutlet weak var welcomeHeader: UILabel!
    
    var facebookLoginUsed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopLoading()
        
        showFacebookLoginButton()
        
        // Keyboard handling for two textfields
        self.usernameTxt.addTarget(self, action: #selector(usernameTextFeildChanged), for: .editingChanged)
        self.passwordTxt.addTarget(self, action: #selector(passwordTextFieldChanged), for: .editingChanged)
        
        loginButton.layer.cornerRadius = 10;
        
        self.passwordErrorLabel.isHidden = true
        self.loginErrorLabel.isHidden = true
        
        self.passwordTxt.isHidden = true
        self.loginButton.isHidden = true
    
        // Adding keyboard toolbars
        addKeyboardToolBarUsernameField()
        addKeyboardToolBarPasswordField()

    }
    
    // MARK: Perform login when correct credentials are enterred setting up session variables
    func performLogin (){
    
        showLoading()
        
        let user = Auth.auth().currentUser
        if let user = user {
            AppSessionConnect.currentLoggedInUser = user.email ?? "";
        }
        
        AppSessionConnect.activeSession = true
        AppSessionConnect.passwordResetMailSent = false
        UserDefaults.standard.set(AppSessionConnect.currentLoggedInUser, forKey: SessionKeys.myUsername.rawValue)
        
        self.dismiss(animated: true, completion: nil)
        
        stopLoading()
        
    }
    
    // MARK: ViewDidAppear
    override func viewDidAppear(_ animated: Bool) {

        if NetworkManagement.isConnectedToNetwork() {
            if AppSessionConnect.passwordResetMailSent == true {
                self.usernameErrorLabel.text = "Password Reset Mail Sent! Please Log In."
                self.usernameErrorLabel.isHidden = false
                self.passwordTxt.text = ""
                self.usernameTxt.text = ""
            }
            else
            {
                
            }
        }
        else
        {
            displayNetworkUnavailableAlert ()
        }
        
        if facebookLoginUsed != false {
            hideFacebookLoginButton ()
            showLoading ()
        }
        
    }
    
    // MARK: Login Button Clicked
    @IBAction func loginButtonClicked(_ sender: Any) {
        
        self.view.endEditing(true)
        showLoading()
        
        self.view.endEditing(true)
        
        if NetworkManagement.isConnectedToNetwork() {
        
            Auth.auth().signIn(withEmail: usernameTxt.text!, password: passwordTxt.text!) { [weak self] user, error in
                guard let strongSelf = self else { return }
                if error != nil {
                    self!.loginErrorLabel.isHidden = false
                }
                else
                {
                    self?.performLogin ()
                }
            }
            
        }
        else
        {
            displayNetworkUnavailableAlert()
        }
        
        stopLoading()
        
    }
    
    // MARK: Forgot Password Navigation
    @IBAction func forgotPasswordClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "PasswordResetSegue", sender: nil)
    }
}

extension LoginAuthViewController: UITextFieldDelegate {
    
    func showLoading () {
        self.activityIndicatorView.isHidden = false
        self.activityIndicatorIcon.startAnimating()
        self.activityIndicatorIcon.isHidden = false
    }
    
    func stopLoading () {
        self.activityIndicatorView.isHidden = true
        self.activityIndicatorIcon.stopAnimating()
        self.activityIndicatorIcon.isHidden = true
    }
    
    @objc func usernameTextFeildChanged() {
        
        if self.usernameTxt.text!.count > 0 {
            hideFacebookLoginButton()
        }
        else
        {
            showFacebookLoginButton()
        }
        
        // MARK: Validating Email
        if self.usernameTxt.text!.count > 0 && self.usernameRegexValidator(usernameValidator: usernameTxt.text!) {
            UIView.animate(withDuration: 0.5){
                self.usernameErrorLabel.isHidden = true
                self.passwordTxt.isHidden = false
            }
        }else
        {
            
            UIView.animate(withDuration: 0.5){
                self.passwordErrorLabel.isHidden = true
                self.loginButton.isHidden = true
                self.usernameErrorLabel.text = "Please enter an valid Email Address"
                self.usernameErrorLabel.isHidden = false
                self.passwordTxt.isHidden = true
            }
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
            UIView.animate(withDuration: 0.5){
                self.passwordErrorLabel.isHidden = false
                self.loginButton.isHidden = true
            }
        }

    }
    
    // MARK: Regular Expressions validating Email & Password
    func usernameRegexValidator(usernameValidator: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: [.caseInsensitive])
        return regex.numberOfMatches(in: usernameValidator, options: [], range: NSMakeRange(0, usernameValidator.characters.count)) > 0
    }
    
    func passwordRegexValidator(passwordValidator: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{6,15}$", options: [.caseInsensitive])
        return regex.numberOfMatches(in: passwordValidator, options: [], range: NSMakeRange(0, passwordValidator.characters.count)) > 0
    }
    
}

// MARK: Setting up keyboard Toolbars
extension LoginAuthViewController {
    
    func addKeyboardToolBarUsernameField() {
        let toolbarStatus = UIToolbar()
        toolbarStatus.sizeToFit()
        
        let clearButton = UIBarButtonItem(title: "Clear", style: .plain, target: nil, action: #selector(clearSelect))
        let doneStatusButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneSelect))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbarStatus.setItems([clearButton, spaceButton, doneStatusButton], animated: false)
        
        self.usernameTxt.inputAccessoryView = toolbarStatus
    }
    
    func addKeyboardToolBarPasswordField() {
        let toolbarStatus = UIToolbar()
        toolbarStatus.sizeToFit()
        
        let clearButton = UIBarButtonItem(title: "Clear", style: .plain, target: nil, action: #selector(clearSelectPsd))
        let doneStatusButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneSelectPsd))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbarStatus.setItems([clearButton, spaceButton, doneStatusButton], animated: false)
        
        self.passwordTxt.inputAccessoryView = toolbarStatus
    }
    
    @objc func doneSelect() {
        self.view.endEditing(true)
    }
    
    @objc func clearSelect() {
        self.usernameTxt.text = ""
    }
    
    @objc func clearSelectPsd() {
        self.passwordTxt.text = ""
    }
    
    @objc func doneSelectPsd() {
        loginButtonClicked (UIButton.self)
        self.view.endEditing(true)
    }
    
    // MARK: Network Availability/Reachability Check
    func displayNetworkUnavailableAlert () {
        let alertView = UIAlertController(title: "Network Error!", message: "Unable to connect to our services because you are not connected to the Internet!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Check Network Settings", style: .default, handler: {(action: UIAlertAction!) in
            
            // Application target is iOS 11
            if let url = URL(string: UIApplication.openSettingsURLString){
                if #available(iOS 11.0, *){
                    UIApplication.shared.open(url, completionHandler: nil)
                }
            }
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action: UIAlertAction!) in
            print ("Cancel Clicked")
        })
        
        alertView.addAction(okAction)
        alertView.addAction(cancelAction)
        self.present(alertView, animated: true)
    }
}

// MARK: Facebook Authentication
extension LoginAuthViewController: LoginButtonDelegate {
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        // Implemented in User Profile
    }
    
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
       
        facebookLoginUsed = true
        
        if AccessToken.current != nil {
            
            self.activityIndicatorView.isHidden = false
            
            let credential = FacebookAuthProvider.credential(withAccessToken: (AccessToken.current?.authenticationToken)!)
            
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                self.showLoading()
                if error != nil {
                    self.showLoading()
                    return
                }
                else
                {
                    self.showLoading()
                    self.performLogin ()
                }
            }
        }
        
        stopLoading()
        
    }
    
    func showFacebookLoginButton () {
        
        self.facebookLoginView.isHidden = false
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email ])
        loginButton.center = view.center
        loginButton.delegate = self
        loginButton.tag = 100
        
        self.view.addSubview(loginButton)
        
    }
    
    func hideFacebookLoginButton () {
        self.facebookLoginView.isHidden = true
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }
    }
    
}
