//
//  Homework.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/12/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import Foundation

class Homework {
    
    var homeworkID: String!
    var homeworkTitle: String!
    var homeworkCategory: String!
    var homeworkStatus: Bool!
    
    init (homeworkID: String, homeworkTitle: String, homeworkCategory: String, homeworkStatus: Bool){
        self.homeworkID = homeworkID
        self.homeworkTitle = homeworkTitle
        self.homeworkCategory = homeworkCategory
        self.homeworkStatus = homeworkStatus
    }
    
}
