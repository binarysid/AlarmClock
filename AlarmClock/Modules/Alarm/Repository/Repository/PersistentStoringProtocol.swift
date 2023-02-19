
import CoreData

// this protocol composed all the required protocol for coredata publishers
typealias PersistentStoringProtocol =  CDEntityCreating & CDSaveModelPublishing & CDDeleteModelPublishing

typealias PersistenceFailure = PersistenceService.Error

protocol CDEntityCreating{
    func createEntity<T:NSManagedObject>(context:NSManagedObjectContext)->T
}
extension CDEntityCreating{
    func createEntity<T:NSManagedObject>(context:NSManagedObjectContext)->T{
        return T(context: context)
    }
}
protocol CDSaveModelPublishing {
    associatedtype T:NSManagedObject
    associatedtype CompletionStatusHandler = (Result<T,PersistenceFailure>)-> Void
    func save(_ context:NSManagedObjectContext, _ action: @escaping CoreDataSaveActionHandler<T>) -> CDSaveModelPublisher<T>
}
extension CDSaveModelPublishing {
    func save(_ context:NSManagedObjectContext, _ action: @escaping CoreDataSaveActionHandler<T>) -> CDSaveModelPublisher<T> {
        return CDSaveModelPublisher(action: action, context: context)
    }
}
protocol CDDeleteModelPublishing {
    associatedtype T:NSManagedObject
    associatedtype CompletionStatusHandler = (Result<Bool,Never>)-> Void
    func erase(_ context:NSManagedObjectContext, _ action: @escaping CoreDataSaveActionHandler<T>) -> CDDeleteModelPublisher<T>
}
extension CDDeleteModelPublishing{
    func erase(_ context:NSManagedObjectContext, _ action: @escaping CoreDataSaveActionHandler<T>) -> CDDeleteModelPublisher<T> {
        return CDDeleteModelPublisher(action: action, context: context)
    }
}
typealias CoreDataSaveActionHandler<T:NSManagedObject> = (()->T?)

