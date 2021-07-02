//
//  ViewController.swift
//  CalcToWin
//
//  Created by Ayşe Nur Bakırcı on 30.06.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainPageTitle: UILabel!
    @IBOutlet weak var mainPageNickname: UILabel!
    @IBOutlet weak var inputNickname: UITextField!
    @IBOutlet weak var buttonContinue: UIButton!
    
    let userModel = UserInfoModel.userInfo
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        buttonContinue.backgroundColor = .blue
        buttonContinue.tintColor = .white
        buttonContinue.bounds = CGRect(x: 20, y: 20, width: 100, height: 50)
        buttonContinue.layer.cornerRadius = 10
    
    }
    override func viewWillAppear(_ animated: Bool) {
        inputNickname.text = ""
    }
    
    @IBAction func clickButtonContinue(_ sender: Any) {
        guard inputNickname.text != "" else {
            makeAlert(title: "Error", message: "Name is empty.")
            return
        }
        userModel.username = inputNickname.text ?? "Error"
        moveOtherPage()
    }
    
    func moveOtherPage() {
        let sb = storyboard?.instantiateViewController(withIdentifier: "bottlePage") as! GameViewController
        navigationController?.pushViewController(sb, animated: true)
    }
    
    func makeAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

