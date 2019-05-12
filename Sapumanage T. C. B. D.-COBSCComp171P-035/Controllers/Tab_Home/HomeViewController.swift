//
//  HomeViewController.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/12/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource {

    var mockStudent = Student(studentID: "tuhan", studentFirstName: "Tuhan", studentLastName: "Sapumanage", studentPhoneNumber: 0770438524, studentBatchName: "BSc (Hons) Computing")
    
    var studentList: [Student] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeTableViewCell
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension HomeViewController: UITableViewDelegate {
    
    // FROM TABLE VIEW DELEGATE
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        studentList.append(mockStudent)
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

