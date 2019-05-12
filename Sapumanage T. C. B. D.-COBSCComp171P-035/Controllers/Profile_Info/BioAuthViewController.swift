//
//  BioAuthViewController.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/12/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import UIKit

class BioAuthViewController: UIViewController {

    let BioAuth = BiometricIDAuth ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        if AppSessionConnect.bioAuth == true {
            self.performSegue(withIdentifier: "ShowProfileInfoSegue", sender: nil)
        }
        else
        {
            authenticator();
        }
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
                self!.performSegue(withIdentifier: "ShowProfileInfoSegue", sender: nil)
            }
        }
        
    }

    
    
}
