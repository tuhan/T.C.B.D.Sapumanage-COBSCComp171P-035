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
    var studentID: String!
    var studentFirstName: String!
    var studentLastName: String!
    var studentPhoneNumber: Int!
    var studentBatchName: String!
    var studentUrlFB: String?
    var studentUsernameFB: String?
    var studentDpURL : String?
    var studentDp: UIImage?
    
    init (studentID: String, studentFirstName: String, studentLastName: String, studentPhoneNumber: Int, studentBatchName: String) {
        
        self.studentID = studentID
        self.studentFirstName = studentFirstName
        self.studentLastName = studentLastName
        self.studentPhoneNumber = studentPhoneNumber
        self.studentBatchName = studentBatchName //Taken from Firebase so no Enum Required
        
    }
    
}

