//
//  BottleInfoViewController.swift
//  CalcToWin
//
//  Created by Ayşe Nur Bakırcı on 1.07.2021.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var bevel: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var sizeSlider: UISlider!
    @IBOutlet weak var bottleLocationSlider: UISlider!
    @IBOutlet weak var bevelSlider: UISlider!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var playButton: UIButton!
    private var bottleLocation: Int = 0
    private var bottleSize: Double = 0.0
    
    let userModel = UserInfoModel.userInfo
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nickname.text = userModel.username
        point.text = "\(userModel.userPoint)"
        playButton.backgroundColor = .blue
        playButton.tintColor = .white
        playButton.bounds = CGRect(x: 20, y: 20, width: 100, height: 50)
        playButton.layer.cornerRadius = 10
        
    }
    
    private func configureSizeSlider() {
        sizeSlider.maximumValue = 1
        sizeSlider.minimumValue = 0.1
    }
    
    private func configureBottleLocationSlider() {
        bottleLocationSlider.maximumValue = 1500
        bottleLocationSlider.minimumValue = 0
    }
    
    private func configureBevelSlider() {
        bevelSlider.maximumValue = 90
        bevelSlider.minimumValue = 0
    }
    
    private func configureSpeedSlider() {
        speedSlider.maximumValue = 100
        speedSlider.minimumValue = 0
    }
    
    @IBAction func sizeSliderChangeValue(_ sender: UISlider) {
        configureSizeSlider()
        size.text = String(format: "%.1f", sender.value)
    }
    
    @IBAction func bottleLocationSliderChangevalue(_ sender: UISlider) {
        configureBottleLocationSlider()
        location.text = String(Int(sender.value))
    }
    
    @IBAction func bevelSliderChangevalue(_ sender: UISlider) {
        configureBevelSlider()
        bevel.text = String(Int(sender.value))
    }
    
    @IBAction func speedSliderChangeValue(_ sender: UISlider) {
        configureSpeedSlider()
        speed.text = String(Int(sender.value))
    }
    
    @IBAction func clickContinueButton(_ sender: Any) {

        if calcHit(bottleSize: Double(size.text ?? "") ?? 0.0, bottleLocation: Int(location.text ?? "") ?? 0, gunBevel: Int(bevel.text ?? "") ?? 0, ballSpeed: Int(bevel.text ?? "") ?? 0) {
            userModel.userPoint += 1
            makeAlert(title: "Success!", message: "You are hit bottle! Do you play again?")
        }else{
            makeAlert(title: "Fail...", message: "You are couldn't hit bottle. Do you play again?")
        }
    }
    
    private func calcHit(bottleSize: Double, bottleLocation: Int, gunBevel: Int, ballSpeed: Int) -> Bool{
        let g = 10
        var location: Double = 0.0
        location = Double(ballSpeed * ballSpeed * Int(sin(Double(2 * gunBevel))) / g)
        if Int(location - bottleSize) <= bottleLocation && bottleLocation <= Int(location + bottleSize){
            return true
        }else{
            return false
        }
        
    }
    
    func makeAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yesButton = UIAlertAction(title: "Yes", style: .default, handler: nil)
        let noButton = UIAlertAction(title: "No", style: .cancel, handler: {action in
            self.userModel.username = ""
            self.userModel.userPoint = 0
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(yesButton)
        alert.addAction(noButton)
        self.present(alert, animated: true, completion: nil)
    }
}
