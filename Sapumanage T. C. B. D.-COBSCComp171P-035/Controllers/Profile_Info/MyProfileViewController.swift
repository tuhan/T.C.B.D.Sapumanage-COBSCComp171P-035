//
//  MyProfileViewController.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/12/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import UIKit
import Kingfisher
import Firebase

class MyProfileViewController: UIViewController {

    @IBOutlet weak var dpImageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    
    @IBOutlet weak var facebookUsername: UIButton!
    
    @IBOutlet weak var notLoggedInErrorLabel: UILabel!
    @IBOutlet weak var authActionButton: UIButton!
    
    @IBOutlet weak var activityIndicatorView: UIView!
    @IBOutlet weak var activityIndicatorIcon: UIActivityIndicatorView!
    
    
    var ref: DatabaseReference!
    var loggedInStudent: Student!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getMyProfileDetails()
        dpImageView.layer.cornerRadius = 52
        
    }
    
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        AppSessionConnect.bioAuth = true
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func signoutButtonClicked(_ sender: Any) {

        do {
            AppSessionConnect.bioAuth = true
            AppSessionConnect.activeSession = false
            AppSessionConnect.currentLoggedInUser = ""
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        }
        catch let err
        {
            print (err)
        }
    }
    
    @IBAction func facebookUsernameButtonClicked(_ sender: Any) {
        
        let fbURL: String = "https://www.facebook.com/\(loggedInStudent.studentUsernameFB ?? "")"
        
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

extension MyProfileViewController {
    
    func getMyProfileDetails() {
        
        UIView.animate(withDuration: 0.5){
            self.showLoading()
        }
        
        ref = Database.database().reference()
        self.ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as! NSDictionary
            
            // Any Print Statement if Needed to Debug
            
            var tempStudentArray: [Student] = []
            
            if snapshot.childrenCount > 0 {
                for student in snapshot.children.allObjects as! [DataSnapshot] {
                    
                    let incomingStudentObject = student.value as! [String: AnyObject]
                    
                    if incomingStudentObject["email"] as! String == AppSessionConnect.currentLoggedInUser {
                        
                        self.notLoggedInErrorLabel.isHidden = true
                        
                        self.firstNameLabel.isHidden = false
                        self.lastNameLabel.isHidden = false
                        self.birthdayLabel.isHidden = false
                        self.ageLabel.isHidden = false
                        self.phoneNumberLabel.isHidden = false
                        self.emailAddressLabel.isHidden = false
                        self.authActionButton.setTitle("Sign Out", for: .normal)
                        
                        let student = Student(studentID: incomingStudentObject["id"] as! String, studentFirstName: incomingStudentObject["firstName"] as! String, studentLastName: incomingStudentObject["lastName"] as! String, studentPhoneNumber: incomingStudentObject["phoneNumber"] as! String, studentBatchName: incomingStudentObject["batchName"] as! String, studentEmailAddress: incomingStudentObject["email"] as! String, studentCity: incomingStudentObject["city"] as! String, studentWorkplace: incomingStudentObject["workplace"] as! String)
                        
                        if incomingStudentObject["dpURL"] as! String != "null"
                        {
                            student.studentDpURL = incomingStudentObject["dpURL"] as? String
                        }
                        else
                        {
                            student.studentDpURL = "https://t3.ftcdn.net/jpg/00/64/67/52/240_F_64675209_7ve2XQANuzuHjMZXP3aIYIpsDKEbF5dD.jpg"
                        }
                        
                        if incomingStudentObject["fbUsername"] as! String != "null"
                        {
                            student.studentUsernameFB = incomingStudentObject["fbUsername"] as? String
                        }
                        else
                        {
                            student.studentUsernameFB = ""
                        }
                        
                        if incomingStudentObject["birthday"] as! String != "null"
                        {
                            student.studentBirthday = incomingStudentObject["birthday"] as? String
                        }
                        else
                        {
                            student.studentBirthday = ""
                        }
                        
                        tempStudentArray.append(student)
                        self.loggedInStudent = tempStudentArray[0]
                        self.populateInformation ()
                        
                    }
                    else
                    {
                        self.firstNameLabel.isHidden = true
                        self.lastNameLabel.isHidden = true
                        self.birthdayLabel.isHidden = true
                        self.ageLabel.isHidden = true
                        self.phoneNumberLabel.isHidden = true
                        self.emailAddressLabel.isHidden = true
                        
                        self.notLoggedInErrorLabel.isHidden = false
                        self.authActionButton.setTitle("Sign In", for: .normal)

                    }
                    
                }
            }
            
            UIView.animate(withDuration: 0.5){
                self.stopLoading()
            }
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func populateInformation (){
        
        if let firstName = loggedInStudent.studentFirstName {
            firstNameLabel.text = firstName
        }
        
        if let lastName = loggedInStudent.studentLastName {
            lastNameLabel.text = lastName
        }
        
        if let birthday = loggedInStudent.studentBirthday {
            birthdayLabel.text = birthday
            let year: Int = Calendar.current.component(.year, from: Date())
            let birthYear: Int = Int(birthday.suffix(4))!

            ageLabel.text = "\(year - birthYear)"
        }
        
        if let phoneNumber = loggedInStudent.studentPhoneNumber {
            phoneNumberLabel.text = phoneNumber
        }
        
        if let emailAddress = loggedInStudent.studentEmailAddress {
            emailAddressLabel.text = emailAddress
        }
        
        if let myProfilePictureURL = loggedInStudent.studentDpURL {
            let dpURL = URL(string: myProfilePictureURL)
            dpImageView.kf.setImage(with: dpURL)
        }
        
        if let fbUsername = loggedInStudent.studentUsernameFB {
            
            if fbUsername != ""
            {
                facebookUsername.isHidden = false
                facebookUsername.setTitle("@\(fbUsername)", for: .normal)
            }
            else
            {
                facebookUsername.isHidden = true
                facebookUsername.isHidden = true
            }
            
        }

    }
    
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
    
    
    
}
