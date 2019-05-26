//
//  Student.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/10/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import Foundation
import UIKit

class Student {
    // MARK: Student Attributes
    var studentID: String!
    var studentFirstName: String!
    var studentLastName: String!
    var studentPhoneNumber: String!
    var studentBirthday: String?
    var studentBatchName: String!
    var studentEmailAddress: String!
    var studentCity: String!
    var studentWorkplace: String!
    var studentUsernameFB: String?
    var studentDpURL : String?
    var studentDp: UIImage?
    
    // MARK: Default Constructor
    init (studentID: String, studentFirstName: String, studentLastName: String, studentPhoneNumber: String, studentBatchName: String, studentEmailAddress: String, studentCity: String, studentWorkplace: String) {
        
        self.studentID = studentID
        self.studentFirstName = studentFirstName
        self.studentLastName = studentLastName
        self.studentPhoneNumber = studentPhoneNumber
        self.studentBatchName = studentBatchName //Taken from Firebase so no Enum Required
        self.studentEmailAddress = studentEmailAddress
        self.studentCity = studentCity
        self.studentWorkplace = studentWorkplace
        
    }
    
}

