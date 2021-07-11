//
//  CreateMealViewController.swift
//  MealList
//
//  Created by Ayşe Nur Bakırcı on 11.07.2021.
//

import UIKit
import CoreData

class CreateMealViewController: UIViewController {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var mealNameTextField: UITextField!
    @IBOutlet weak var selectImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        saveButton.backgroundColor = .blue
        saveButton.layer.cornerRadius = 15
        saveButton.tintColor = .white
        
        selectImageView.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
        selectImageView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func choosePhoto() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonClick(_ sender: Any) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        let newCook = NSEntityDescription.insertNewObject(forEntityName: "MealList", into: context)
        newCook.setValue(mealNameTextField.text, forKey: "mealName")
        let imageData = selectImageView.image?.jpegData(compressionQuality: 0.5)
        newCook.setValue(imageData, forKey: "mealImage")
        newCook.setValue(UUID(), forKey: "mealID")
        
        do {
            try context.save()
        } catch  {
            print("Kayıt Hatası")
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension CreateMealViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {}
