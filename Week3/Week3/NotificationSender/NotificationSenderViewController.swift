//
//  NotificationSenderViewController.swift
//  Week3
//
//  Created by Ayşe Nur Bakırcı on 8.07.2021.
//

import UIKit

class NotificationSenderViewController: UIViewController {
    
    var notificationData: [String: Any] = [:]
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func sendButtonClick(_ sender: Any) {
        
        notificationData["message"] = messageTextField.text
        
        NotificationCenter.default.post(name: .sendDataNotification, object: nil, userInfo: notificationData)
        dismiss(animated: true, completion: nil)
    }
    
}
