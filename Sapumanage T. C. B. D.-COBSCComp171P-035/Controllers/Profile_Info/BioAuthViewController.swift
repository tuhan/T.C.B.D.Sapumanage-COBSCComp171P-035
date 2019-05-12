//
//  BioAuthViewController.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/12/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import UIKit

class BioAuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        if AppSessionConnect.bioAuth == true {
            self.performSegue(withIdentifier: "ShowProfileInfoSegue", sender: nil)
        }
        else
        {

        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        AppSessionConnect.bioAuth = false
    }
    
    
    
}
