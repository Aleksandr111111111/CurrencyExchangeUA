//
//  SettingsController.swift
//  Chenge
//
//  Created by Aleksander Kulikov on 09.12.2020.
//

import UIKit

class SettingsController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBAction func pushShowCourses(_ sender: Any) {
        ModelUA.shared.loadXMLFile(date: datePicker.date)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pushCancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        // Do any addit/Users/avkulikov/Documents/doki/Chenge/Chenge/SettingsController.swiftional setup after loading the view.
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

