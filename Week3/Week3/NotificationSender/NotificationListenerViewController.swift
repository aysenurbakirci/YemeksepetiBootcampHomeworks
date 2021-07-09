//
//  NotificationListenerViewController.swift
//  Week3
//
//  Created by Ayşe Nur Bakırcı on 8.07.2021.
//

import UIKit

class NotificationListenerViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let notificationCenter: NotificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(handleData(notification:)), name: .sendDataNotification, object: nil)
    }
    
    @objc func handleData(notification: Notification) {
        if let message = notification.userInfo?["message"] as? String{
            messageLabel.text = message
        }
    }
    
    //segue kullanılarak yönlendirildi
    @IBAction func listenButtonClick(_ sender: Any) {
        
    }
    
}

extension Notification.Name {
    
    static let sendDataNotification = Notification.Name(rawValue: "sendData")
}
