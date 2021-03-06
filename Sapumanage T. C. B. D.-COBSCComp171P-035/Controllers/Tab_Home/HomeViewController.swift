//
//  HomeViewController.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/12/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

// CREDITS: https://stackoverflow.com/questions/39768600/how-to-programmatically-set-action-for-barbuttonitem-in-swift-3/39768655

import UIKit
import FirebaseAuth
import Firebase
import Alamofire
import Kingfisher

class HomeViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIView!
    @IBOutlet weak var activityIndicatorIcon: UIActivityIndicatorView!
    
    
    var ref: DatabaseReference!
    var networkConnected: Bool = false
    
    var studentList: [Student] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refreshTapped))
        
        if NetworkManagement.isConnectedToNetwork() {
            getStudentList()
        }
        else{
            displayNetworkUnavailableAlert()
        }
        
    }
    
    @objc func refreshTapped () {
        getStudentList()
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
    
    // MARK: Retriving the actual student list (Full List)
    func getStudentList() {
        
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
                    
                    if (incomingStudentObject["email"] as! String != AppSessionConnect.currentLoggedInUser) {
                        
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
                        
                    }
                }
            }
            
            self.studentList = tempStudentArray
            self.tableView.reloadData()
            
            UIView.animate(withDuration: 0.5){
                self.stopLoading()
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}

// MARK: Retriving and populating the TableView
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomePageTableViewCell", for: indexPath) as! HomePageTableViewCell
        
        // MARK: Ensuring Validations
        if let firstName = studentList[indexPath.row].studentFirstName {
            if let lastName = studentList[indexPath.row].studentLastName {
                cell.nameLabel.text = "\(firstName) \(lastName)"
            }
        }
        
        if let cityName = studentList[indexPath.row].studentCity {
            cell.phoneNumberLabel.text = "\(cityName)"
        }
        
        if let dpURL = studentList[indexPath.row].studentDpURL {
            cell.dpImageView.layer.cornerRadius = 22.5
            let url = URL(string: studentList[indexPath.row].studentDpURL!)
            cell.dpImageView.kf.setImage(with: url)
        }
        
        return cell
    }
    
    // MARK: FROM TABLE VIEW DELEGATE
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ViewUserSegue", sender: studentList[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // FUNCTION WHEN ITS CLICKED
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // VALIDATING WHICH SEGUE WHEN THERE ARE MULTIPLE SEGUES
        if segue.identifier == "ViewUserSegue" {
            
            let selectedStudent = sender as! Student
            let destinationVC = segue.destination as! StudentInfoViewController // INITIALIZING LANDING VIEW CONTROLLER
            destinationVC.studentInfo = selectedStudent
            
        }
        
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

