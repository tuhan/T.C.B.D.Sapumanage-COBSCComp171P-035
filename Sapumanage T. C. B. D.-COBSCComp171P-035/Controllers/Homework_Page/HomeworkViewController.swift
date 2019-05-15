//
//  HomeworkViewController.swift
//  Sapumanage T. C. B. D.-COBSCComp171P-035
//
//  Created by Tuhan Sapumanage on 5/12/19.
//  Copyright © 2019 Tuhan Sapumanage. All rights reserved.
//

import UIKit

class HomeworkViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var homeworkArray: [Homework] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if UserDefaults.standard.object(forKey: "homeworkList") != nil {
            homeworkArray = NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.object(forKey: "homeworkList") as! Data) as! [Homework]
            self.tableView.reloadData()
        }
        else
        {
            // If need say there aren't any homework to display
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeworkArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeworkTableViewCell", for: indexPath) as! HomeworkTableViewCell
        
        cell.homeworkTitle.text = homeworkArray[indexPath.row].homeworkTitle
        cell.categoryLabel.text = homeworkArray[indexPath.row].homeworkCategory
        cell.descLabel.text = homeworkArray[indexPath.row].homeworkDesc
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 73;
    }

}

extension HomeworkViewController {
    
    // FROM TABLE VIEW DELEGATE
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "HomeworkInfoSegue", sender: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // FUNCTION WHEN ITS CLICKED
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // VALIDATING WHICH SEGUE WHEN THERE ARE MULTIPLE SEGUES
        if segue.identifier == "HomeworkInfoSegue" {
            
            let indexPassed: Int = sender as! Int
            let destinationVC = segue.destination as! InfoHomeworkViewController // INITIALIZING LANDING VIEW CONTROLLER
            destinationVC.selectedHomeworkIndex = indexPassed
            
        }
        
    }
    
}
