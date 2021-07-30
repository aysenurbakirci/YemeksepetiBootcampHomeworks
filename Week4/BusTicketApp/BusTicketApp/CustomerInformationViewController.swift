//
//  CustomerInformationViewController.swift
//  BusTicketApp
//
//  Created by Ayşe Nur Bakırcı on 26.07.2021.
//

import UIKit

class CustomerInformationViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    
    var selectedSeatList: [Int] = []
    var date: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.locale = .current
        datePicker.date = Date()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.addTarget(self, action: #selector(getDatePickerDate), for: .valueChanged)

        
    }
    @objc func getDatePickerDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        date = dateFormatter.string(from: datePicker.date)
    }
    
    @IBAction func clickCancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickBuyButton(_ sender: Any) {
        if emptyValues() {
            _ = self.navigationController?.popViewController(animated: true)
            let previousViewController = self.navigationController?.viewControllers.last as! ViewController
            previousViewController.newSoldedSeats = selectedSeatList
            previousViewController.selectedSeats = []
        }
    }
    
    func emptyValues() -> Bool {
        
        if nameTextField.text == "" {
            makeAlert(title: "Error", message: "Name is empty.")
            return false
        } else if surnameTextField.text == "" {
            makeAlert(title: "Error", message: "Surname is empty.")
            return false
        } else {
            return true
        }
    }
    
    private func makeAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
    }
}
