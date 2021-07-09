//
//  ViewController.swift
//  Week3
//
//  Created by Ayşe Nur Bakırcı on 7.07.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var cookList: [CookModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCooks()
    }
    
    private func getCooks() {
        
        cookList.removeAll()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CookList")
        print("cooklist : \(cookList)")
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    guard let name = result.value(forKey: "cookName") as? String, let image = result.value(forKey: "cookImage") as? NSData else { return }
                    cookList.append(CookModel(cookName: name, cookImage: image, insertIntoManagedObjectContext: context))
                    print("cooklist for: \(cookList)")
                }
                self.tableView.reloadData()
            } else {}
        } catch {
            print("Error")
        }

    }
    
    private func deleteCook(deleteObject: CookModel) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CookList")
        print("cooklist : \(cookList)")
        do {
            if (try? context.fetch(fetchRequest)) != nil {
                context.delete(deleteObject)
            }
        } catch {
            print("Error")
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "MealTableViewCell", bundle: nil), forCellReuseIdentifier: "MealTableViewCell")
                let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell") as! MealTableViewCell
        cell.cellMealName.text = cookList[indexPath.row].cookName
        let uiImage: UIImage = UIImage(data: cookList[indexPath.row].cookImage! as Data)!
        cell.cellMealImage.image = uiImage
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Yemek Sil", message: "\(cookList[indexPath.row].cookName ?? "Yemek") silinecek. Emin misiniz?", preferredStyle: .alert)
        let delete = UIAlertAction(title: "Sil", style: .destructive, handler: {_ in
            
            self.cookList.remove(at: indexPath.row)
            self.deleteCook(deleteObject: self.cookList[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        })
        let cancel = UIAlertAction(title: "Vazgeç", style: .cancel, handler: nil)
        alert.addAction(delete)
        alert.addAction(cancel)
        
        if editingStyle == UITableViewCell.EditingStyle.delete{
            present(alert, animated: true, completion: nil)
        }
    }
}
