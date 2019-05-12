//
//  MyProfileViewController.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/12/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import UIKit
import Firebase

class MyProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        AppSessionConnect.bioAuth = false
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func signoutButtonClicked(_ sender: Any) {

        print ("It's Working")
        do {
            AppSessionConnect.activeSession = false
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        }
        catch let err
        {
            print (err)
        }
    }
}
