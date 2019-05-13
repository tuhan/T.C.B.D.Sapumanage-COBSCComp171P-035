//
//  InfoHomeworkViewController.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/13/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import UIKit

class InfoHomeworkViewController: UIViewController {

    
    @IBOutlet weak var homeworkTitleTextField: UITextField!
    @IBOutlet weak var homeworkDescription: UITextView!
    @IBOutlet weak var homeworkCategorySwitch: UISwitch!

    var selectedHomeworkIndex: Int?
    var homeworkArray = NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.object(forKey: "homeworkList") as! Data) as! [Homework]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var selectedHomework = homeworkArray [selectedHomeworkIndex!]
        
        self.homeworkTitleTextField.text = selectedHomework.homeworkTitle
        self.homeworkDescription.text = selectedHomework.homeworkDesc
        
        if selectedHomework.homeworkCategory == "Acadamic"{
            homeworkCategorySwitch.setOn(true, animated: true)
        }
        else
        {
            homeworkCategorySwitch.setOn(false, animated: true)
        }
        
    }
    
    @IBAction func saveInfoButtonClicked(_ sender: Any) {
        
        var homeworkType: String = ""
        
        if homeworkCategorySwitch.isOn {
            homeworkType = "Acadamic"
        }
        else
        {
            homeworkType = "Non-Acadamic"
        }
        
        let updatedHomework = Homework(json: ["homeworkTitle": homeworkTitleTextField.text, "homeworkCategory": homeworkType, "homeworkDesc": homeworkDescription.text])
        
        
        homeworkArray[selectedHomeworkIndex!] = updatedHomework
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: homeworkArray)
        UserDefaults.standard.set(encodedData, forKey: "homeworkList")
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func deleteNoteClicked(_ sender: Any) {
        homeworkArray.remove(at: selectedHomeworkIndex!)
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: homeworkArray)
        UserDefaults.standard.set(encodedData, forKey: "homeworkList")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
