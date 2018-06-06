//
//  DetailViewController.swift
//  MyTodoList
//
//  Created by Alonso Manilla on 6/5/18.
//  Copyright © 2018 INGOMEZ. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var item: String?
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Item: \(String(describing: item))")
        descriptionLabel.text? = self.item!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dateSelected(_ sender: UIDatePicker) {
        print("fcha seleccionada: \(sender.date)")
        self.dateLabel.text = formatDate(date: sender.date)
    }
    
    @IBAction func addNotification(_ sender: UIBarButtonItem) {
        if let dateString = self.dateLabel.text {
            if let date = parseDate(date: dateString) {
                scheduleNotification(message: self.item!, date: date)
            }
        }
    }
    
    func scheduleNotification(message: String, date: Date) {
        let localNotification = UILocalNotification()
        localNotification.fireDate = date
        localNotification.timeZone = NSTimeZone.default
        localNotification.alertBody = message
        localNotification.alertTitle = "Recuerda esta tarea"
        localNotification.applicationIconBadgeNumber = 1
        UIApplication.shared.scheduleLocalNotification(localNotification)
    }
    
    func parseDate(date: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .full
        return formatter.date(from: date)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .full
        return formatter.string(from: date)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
