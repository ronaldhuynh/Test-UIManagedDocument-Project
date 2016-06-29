//
//  ManagedDocumentStack.swift
//  TestUIManagedDocumentProject
//
//  Created by Ronald Huynh on 28/06/2016.
//  Copyright © 2016 Ronald Huynh. All rights reserved.
//

import UIKit
import CoreData

private let ManagedObjectModelName = "TestUIManagedDocumentProject"

class ManagedDocumentStack: NSObject {

    private static let StackManager = ManagedDocumentStack()
    private let managedDocument: UIManagedDocument

    internal class func sharedDocumentManager() -> ManagedDocumentStack {
        return StackManager
    }

    override init() {
        managedDocument = UIManagedDocument(fileURL: NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last!)

        super.init()
    }

    func undoChanges() {
        managedDocument.undoManager.undo()
    }
}


//MARK: - Person methods
extension ManagedDocumentStack {
    func fetchAllPeopleOnContext(fetchContext: NSManagedObjectContext) -> [Person]? {
        let fetchRequest = NSFetchRequest(entityName: "Person")
        fetchRequest.predicate = NSPredicate(value: true)

        do {
            guard let persons = try fetchContext.executeFetchRequest(fetchRequest) as? [Person] else {
                return nil
            }
            return persons
        } catch {
            print("Error has occurred: \(error)")
        }
        return nil
    }
}


//MARK: - Context methods
extension ManagedDocumentStack {
    func mainContext() -> NSManagedObjectContext {
        return managedDocument.managedObjectContext
    }

    func newMergeContext(concurrencyType: NSManagedObjectContextConcurrencyType) -> NSManagedObjectContext {
        let mergeContext = NSManagedObjectContext(concurrencyType: concurrencyType)
        mergeContext.parentContext = self.managedDocument.managedObjectContext
        mergeContext.undoManager = self.managedDocument.undoManager

        return mergeContext
    }
}
