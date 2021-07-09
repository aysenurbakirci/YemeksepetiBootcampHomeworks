//
//  CreateCookViewController.swift
//  Week3
//
//  Created by Ayşe Nur Bakırcı on 7.07.2021.
//

import UIKit
import CoreData

class CreateCookViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var cookImageView: UIImageView!
    @IBOutlet weak var cookNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cookImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
        cookImageView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc func choosePhoto() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        cookImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func createCookButtonClick(_ sender: Any) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let newCook = NSEntityDescription.insertNewObject(forEntityName: "CookList", into: context)
        newCook.setValue(cookNameTextField.text, forKey: "cookName")
        let imageData = cookImageView.image?.jpegData(compressionQuality: 0.5)
        newCook.setValue(imageData, forKey: "cookImage")
        
        do{
            try context.save()
        }catch{
            print("Failure")
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
