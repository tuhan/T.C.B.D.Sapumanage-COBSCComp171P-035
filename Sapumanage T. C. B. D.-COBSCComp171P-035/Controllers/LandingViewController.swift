//
//  LandingViewController.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/10/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
        if AppSessionConnect.activeSession != true {
            self.performSegue(withIdentifier: "AuthSegue", sender: nil)
        }
        else
        {
            self.performSegue(withIdentifier: "TabsSegue", sender: nil)
        }
        
    }

}
