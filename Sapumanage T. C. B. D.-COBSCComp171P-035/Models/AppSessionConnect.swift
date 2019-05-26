//
//  AppSessionConnect.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/12/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import Foundation

enum SessionKeys: String {

    case myHomework = "homeworkArray"
    case myUsername = "username"

}

class AppSessionConnect {
    
    //TODO: FALSE & ""
    public static var activeSession: Bool = false
    public static var currentLoggedInUser: String = ""
    
    // BioAuth Related | Default: false
    public static var bioAuth: Bool = false
    public static var bioAuthOnce: Bool = false
    
    public static var passwordResetMailSent: Bool = false
    
}
