//
//  HomeViewController.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/12/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import Alamofire
import Kingfisher

class HomeViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var ref: DatabaseReference!
    
    var studentList: [Student] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStudentList()
    }
    
    func getStudentList() {
        
        ref = Database.database().reference()
        self.ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as! NSDictionary
            print(value)
            
            var tempStudentArray: [Student] = []
            
            if snapshot.childrenCount > 0 {
                for student in snapshot.children.allObjects as! [DataSnapshot] {

                    let incomingStudentObject = student.value as! [String: AnyObject]
                    let student = Student(studentID: incomingStudentObject["id"] as! String, studentFirstName: incomingStudentObject["firstName"] as! String, studentLastName: incomingStudentObject["lastName"] as! String, studentPhoneNumber: incomingStudentObject["phoneNumber"] as! String, studentBatchName: incomingStudentObject["batchName"] as! String, studentCity: incomingStudentObject["city"] as! String, studentWorkplace: incomingStudentObject["workplace"] as! String)
                    
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
            
            self.studentList = tempStudentArray
            self.tableView.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomePageTableViewCell", for: indexPath) as! HomePageTableViewCell
        
        // Ensuring Validations
        if let firstName = studentList[indexPath.row].studentFirstName {
            if let lastName = studentList[indexPath.row].studentLastName {
                cell.nameLabel.text = "\(firstName) \(lastName)"
            }
        }
        
        if let mobileNumber = studentList[indexPath.row].studentPhoneNumber {
            cell.phoneNumberLabel.text = "\(mobileNumber)"
        }
        
        if let dpURL = studentList[indexPath.row].studentDpURL {
            cell.dpImageView.layer.cornerRadius = 22.5
            let url = URL(string: studentList[indexPath.row].studentDpURL!)
            cell.dpImageView.kf.setImage(with: url)
        }
        
        return cell
    }
    
    // FROM TABLE VIEW DELEGATE
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
    
}

