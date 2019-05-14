//
//  StudentInfoViewController.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/12/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import UIKit

class StudentInfoViewController: UIViewController {

    var studentInfo: Student!
    
    @IBOutlet weak var dpImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var batchNameLabel: UILabel!

    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var currentCityLabel: UILabel!
    @IBOutlet weak var workplaceLabel: UILabel!

    @IBOutlet weak var fbLogoImageView: UIImageView!
    @IBOutlet weak var fbUsernameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dpURL = studentInfo.studentDpURL {
            dpImageView.layer.cornerRadius = 22.5
            let url = URL(string: dpURL)
            dpImageView.kf.setImage(with: url)
        }
        
        if let firstName = studentInfo.studentFirstName {
            if let lastName = studentInfo.studentLastName{
                fullNameLabel.text = "\(firstName) \(lastName)"
            }
        }
        
        if let batchName = studentInfo.studentBatchName {
            batchNameLabel.text = "\(batchName)"
        }
        
        if let birthday = studentInfo.studentBirthday {
            birthdayLabel.text = "\(birthday)"
        }
        
        if let phoneNumber = studentInfo.studentPhoneNumber {
            phoneNumberLabel.text = "\(phoneNumber)"
        }
        
        if let currentCity = studentInfo.studentCity {
            currentCityLabel.text = "\(currentCity)"
        }
        
        if let workplace = studentInfo.studentWorkplace {
            workplaceLabel.text = "\(workplace)"
        }
        
        if let fbUsername = studentInfo.studentUsernameFB {
            
            if fbUsername != ""
            {
                fbLogoImageView.isHidden = false
                fbUsernameButton.isHidden = false
                fbUsernameButton.setTitle("@\(fbUsername)", for: .normal)
            }
            else
            {
                fbLogoImageView.isHidden = true
                fbUsernameButton.isHidden = true
            }
            
        }
        
        
    }
    

    @IBAction func doneButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //Redirect when profile username is clicked
    @IBAction func fbButtonClicked(_ sender: Any) {
        
        let fbURL: String = "https://www.facebook.com/\(studentInfo.studentUsernameFB ?? "")"
        
        guard let url = URL(string: fbURL) else {
            return // Handling Possible Errors that Might Arise
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }

    }
}
