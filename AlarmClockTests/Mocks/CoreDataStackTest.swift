//
//  CoreDataStackTest.swift
//  AlarmClockTests
//
//  Created by Linkon Sid on 30/1/23.
//


import XCTest
import CoreData
@testable import AlarmClock

final class CoreDataStackTest{
    static let shared = CoreDataStackTest()
    private init(){}
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
            return managedObjectModel
        }()
    var mainContext:NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    var backgroundContext:NSManagedObjectContext{
        get{
            let context = persistentContainer.newBackgroundContext()
            context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            return context
        }
    }
    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: PersistenceService.ContainerName,managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
//                description.url = URL(fileURLWithPath: "/dev/null")
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//             Check if the data store is in memory
            precondition( storeDescription.type == NSInMemoryStoreType )
            if let error = error as NSError? {
                XCTFail(error.localizedDescription)
            }
        })
        return container
    }()
}
extension NSPersistentContainer {

    func destroyPersistentStore() {
        do{
            try persistentStoreCoordinator.performAndWait {
                let persistentStore = try unwrapPersistentStore()
                try persistentStoreCoordinator.remove(persistentStore)
//                let fileURL = try unwrapPersistentStoreURL()
//                try FileManager.default.removeItem(
//                    at: fileURL.deletingLastPathComponent()
//                )
            }
        }catch let error{
            XCTFail("Failed to remove store.\(error.localizedDescription)")
        }
    }
    func unwrapPersistentStore() throws -> NSPersistentStore {
            return try XCTUnwrap(persistentStoreCoordinator.persistentStores.first(where: {$0.type == NSInMemoryStoreType}))
    }

    func unwrapPersistentStoreURL() throws -> URL {
        return try XCTUnwrap(unwrapPersistentStore().url)
    }
}
