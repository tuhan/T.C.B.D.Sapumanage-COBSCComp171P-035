//
//  BioAuthViewController.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/12/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import UIKit

class BioAuthViewController: UIViewController {

    @IBOutlet weak var pageMainLabel: UILabel!
    @IBOutlet weak var viewProfileButton: UIButton!
    let BioAuth = BiometricIDAuth ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewProfileButton.isHidden = true
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        
        if AppSessionConnect.activeSession != true {
            self.dismiss(animated: true, completion: nil)
        }
        else
        {
            if AppSessionConnect.bioAuth == true {
                self.viewProfileButton.isHidden = false
            }
            else
            {
                self.viewProfileButton.isHidden = true
                authenticator();
            }
        }
        
    }
    
    @IBAction func viewProfileButtonClicked(_ sender: Any) {
        authenticator()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        AppSessionConnect.bioAuth = false
    }
    
    func authenticator () {
        
        BioAuth.authenticateUser() { [weak self] message in
            if let message = message {
                let alertView = UIAlertController(title: "Authentication Error", message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: {(action: UIAlertAction!) in print ("Try Again")})
                alertView.addAction(okAction)
                self!.present(alertView, animated: true)
            }
            else
            {
                AppSessionConnect.bioAuth = true
                self?.viewProfileButton.isHidden = true
                self!.performSegue(withIdentifier: "ShowProfileInfoSegue", sender: nil)
            }
        }
        self.viewProfileButton.isHidden = false
    }

    
    
}
