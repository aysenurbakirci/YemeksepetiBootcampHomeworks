//
//  CookModel.swift
//  Week3
//
//  Created by Ayşe Nur Bakırcı on 7.07.2021.
//

import Foundation
import UIKit
import CoreData

class CookModel: NSManagedObject{
    @NSManaged var cookName: String?
    @NSManaged var cookImage: NSData?
    
    convenience init(cookName: String, cookImage: NSData, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        let entity = NSEntityDescription.entity(forEntityName: "CookList", in: context)!
        self.init(entity: entity, insertInto: context)
        self.cookName = cookName
        self.cookImage = cookImage
    }
}
