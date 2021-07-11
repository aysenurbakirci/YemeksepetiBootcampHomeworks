//
//  ViewController.swift
//  MealList
//
//  Created by Ayşe Nur Bakırcı on 11.07.2021.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    @IBOutlet weak var mealTableView: UITableView!
    var mealList: [MealModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mealTableView.delegate = self
        mealTableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMealList()
    }
    
    private func getMealList() {
        mealList.removeAll()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MealList")
        
        do{
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    guard let name = result.value(forKey: "mealName") as? String, let image = result.value(forKey: "mealImage") as? Data else {
                        return
                    }
                    if let id = result.value(forKey: "mealID") as? UUID {
                        mealList.append(MealModel(mealName: name, mealImage: UIImage(data: image) ?? UIImage(), mealID: id))
                    } else {
                        mealList.append(MealModel(mealName: name, mealImage: UIImage(data: image) ?? UIImage(), mealID: UUID()))
                    }
                    
                }
                self.mealTableView.reloadData()
            }
        } catch{
            print("Error")
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mealList.count == 0 {
            self.mealTableView.setEmptyMessage("You have no food left. Please add food.")
        }else{
            self.mealTableView.restore()
        }
        return mealList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath)
        
        cell.textLabel?.text = mealList[indexPath.row].mealName
        cell.imageView?.image = mealList[indexPath.row].mealImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Delete Meal", message: "Are you sure?", preferredStyle: .alert)
            let deleteButton = UIAlertAction(title: "Delete", style: .destructive, handler: {_ in
                self.removeMeal(id: self.mealList[indexPath.row].mealID)
                self.mealList.remove(at: indexPath.row)
                self.mealTableView.deleteRows(at: [indexPath], with: .automatic)
            })
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(deleteButton)
            alert.addAction(cancelButton)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    func removeMeal(id: UUID) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MealList")
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    guard let mealID = result.value(forKey: "mealID")as? UUID else { return }
                    if id == mealID {
                        context.delete(result)
                    }
                }
                try context.save()
            }
        } catch {
            print("Error")
        }
    }
}

extension UITableView {
    func setEmptyMessage(_ message: String) {
        
        let lblMessage = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        lblMessage.text = message
        lblMessage.textColor = .black
        lblMessage.numberOfLines = 0
        lblMessage.textAlignment = .center
        
        let image = UIImageView(image: UIImage(named: "emptyList"))
        image.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height * 0.4)
        
        let stack = UIStackView(arrangedSubviews: [image, lblMessage])
        stack.axis = .vertical
        stack.alignment = .center
        
        self.backgroundView = stack
        self.separatorStyle = .none
    }
    
    func restore() {
        
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
