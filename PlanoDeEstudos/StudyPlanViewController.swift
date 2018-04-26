//
//  StudyViewController.swift
//  PlanoDeEstudos
//
//  Created by Eric Brito
//  Copyright © 2017 Eric Brito. All rights reserved.

import UIKit
import UserNotifications

class StudyPlanViewController: UIViewController {

    @IBOutlet weak var tfCourse: UITextField!
    @IBOutlet weak var tfSection: UITextField!
    @IBOutlet weak var dpDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dpDate.minimumDate = Date()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func schedule(_ sender: UIButton) {
        
        let id = String(Date().timeIntervalSince1970)
        let studyPlan = StudyPlan(course: tfCourse.text!, section: tfSection.text!, date: dpDate.date, done: false, id: id)
        
        let content = UNMutableNotificationContent()
        content.title = "Lembrete"
        content.subtitle = "Matéria \(studyPlan.course)"
        content.body = "Está na hora de estudar \(studyPlan.section)"
        content.categoryIdentifier = "Lembrete"
        content.badge = 5
        
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: studyPlan.date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "Lembrete", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            print(error)
        }
        
        StudyManager.shared.addPlan(studyPlan)
        
        navigationController?.popViewController(animated: true)
        
    }
    
}
