//
//  LandingViewController.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/10/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import UIKit
import Firebase

class LandingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
        // MARK: See if a user is already logged in. If Yes, Continue to Tabbed pane skipping Login (Needed When the App is Closed and Reopened)
        if UserDefaults.standard.string(forKey: SessionKeys.myUsername.rawValue) != nil {
            
            let user = Auth.auth().currentUser
            if let user = user {
                AppSessionConnect.currentLoggedInUser = user.email ?? "";
            }
            
            AppSessionConnect.activeSession = true
            AppSessionConnect.passwordResetMailSent = false
            
            self.performSegue(withIdentifier: "TabsSegue", sender: nil)
        }
        
        // MARK: See if there is an active session (Needed When the App is Running on Background)
        if AppSessionConnect.activeSession != true {
            self.performSegue(withIdentifier: "AuthSegue", sender: nil)
        }
        else
        {
            self.performSegue(withIdentifier: "TabsSegue", sender: nil)
        }
        
    }

}
