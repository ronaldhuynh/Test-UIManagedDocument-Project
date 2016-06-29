//
//  Person.swift
//  TestUIManagedDocumentProject
//
//  Created by Ronald Huynh on 29/06/2016.
//  Copyright © 2016 Ronald Huynh. All rights reserved.
//

import Foundation
import CoreData


class Person: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    class func createNewPersonInContext(managedObjectContext: NSManagedObjectContext = ManagedDocumentStack.sharedDocumentManager().mainContext()) -> Person? {
        if let newPerson = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: managedObjectContext) as? Person {
            newPerson.name = "TEST"
            newPerson.birthday = NSDate()
            newPerson.age = 555
            newPerson.lastName = "HAHA"

            return newPerson
        }

        return nil
    }

}
