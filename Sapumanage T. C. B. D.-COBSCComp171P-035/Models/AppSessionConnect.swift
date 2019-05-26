//
//  AppSessionConnect.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/12/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import Foundation

// MARK: Keys to store and retrive UserDefaults
enum SessionKeys: String {

    case myHomework = "homeworkArray"
    case myUsername = "username"

}

class AppSessionConnect {
    
    public static var activeSession: Bool = false // Default: false
    public static var currentLoggedInUser: String = "" // Default: ""
    
    public static var bioAuth: Bool = false // Default: false
    public static var bioAuthOnce: Bool = false // Default: false
    
    public static var passwordResetMailSent: Bool = false // Default: false
    
    public static var studentList: [Student] = []
    
}
