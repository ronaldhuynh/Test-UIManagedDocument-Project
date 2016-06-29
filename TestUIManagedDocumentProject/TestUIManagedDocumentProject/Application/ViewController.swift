//
//  ViewController.swift
//  TestUIManagedDocumentProject
//
//  Created by Ronald Huynh on 28/06/2016.
//  Copyright © 2016 Ronald Huynh. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Add person into entity
        test1()
        test2()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Test 1: Add item to main Context, save then revert changes
    func test1() {
            addPersonToContext(ManagedDocumentStack.sharedDocumentManager().mainContext())
            let take2 = ManagedDocumentStack.sharedDocumentManager().fetchAllPeopleOnContext(ManagedDocumentStack.sharedDocumentManager().mainContext())

            let fetchRequest = NSFetchRequest(entityName: "Person")
            fetchRequest.predicate = NSPredicate(value: true)
            //Save changes
            do {
                try ManagedDocumentStack.sharedDocumentManager().mainContext().save()
                ManagedDocumentStack.sharedDocumentManager().undoChanges()
                print("TEST")
            } catch {

            }
    }

    //Test 2: Add item to main and new merge context, undo changes, what happens to the contexts?
    func test2() {
        let mergeContext = ManagedDocumentStack.sharedDocumentManager().newMergeContext(.MainQueueConcurrencyType)
        addPersonToContext(ManagedDocumentStack.sharedDocumentManager().mainContext())
        addPersonToContext(mergeContext)

        do {
            try mergeContext.save()
            try ManagedDocumentStack.sharedDocumentManager().mainContext().save()

            let fetchRequest = NSFetchRequest(entityName: "Person")
            fetchRequest.predicate = NSPredicate(value: true)

            let main = try ManagedDocumentStack.sharedDocumentManager().mainContext().executeFetchRequest(fetchRequest)
            let secondary = try mergeContext.executeFetchRequest(fetchRequest)

            print("HAHA")

            //Revert changes
            ManagedDocumentStack.sharedDocumentManager().undoChanges()
            print("")

        } catch {

        }
    }

    private func addPersonToContext(context: NSManagedObjectContext) {
        Person.createNewPersonInContext(context)
    }
}
