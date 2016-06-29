//
//  Person+CoreDataProperties.swift
//  TestUIManagedDocumentProject
//
//  Created by Ronald Huynh on 29/06/2016.
//  Copyright © 2016 Ronald Huynh. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Person {

    @NSManaged var name: String?
    @NSManaged var age: NSNumber?
    @NSManaged var birthday: NSDate?
    @NSManaged var lastName: String?

}
