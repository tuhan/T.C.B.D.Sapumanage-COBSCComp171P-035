//
//  Homework.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/12/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import Foundation

class Homework: NSObject, NSCoding {
    
    var homeworkTitle: String?
    var homeworkCategory: String?
    var homeworkDesc: String?
    
    init(json: [String: Any])
    {
        self.homeworkTitle = json["homeworkTitle"] as? String
        self.homeworkCategory = json["homeworkCategory"] as? String
        self.homeworkDesc = json["homeworkDesc"] as? String
    }

    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(self.homeworkTitle, forKey: "homeworkTitle")
        aCoder.encode(self.homeworkCategory, forKey: "homeworkCategory")
        aCoder.encode(self.homeworkDesc, forKey: "homeworkDesc")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.homeworkTitle = aDecoder.decodeObject(forKey: "homeworkTitle") as? String
        self.homeworkCategory = aDecoder.decodeObject(forKey: "homeworkCategory") as? String
        self.homeworkDesc = aDecoder.decodeObject(forKey: "homeworkDesc") as? String
    }
    
}
