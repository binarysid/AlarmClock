//
//  AlarmLocalDataSource.swift
//  AlarmClock
//
//  Created by Linkon Sid on 28/1/23.
//
import CoreData
import Combine

protocol AlarmLocalDataSourceProtocol{
    
    var mainContext:NSManagedObjectContext{get}
    var backgroundContext:NSManagedObjectContext{get}
    func create(request:CreateAlarmRequestor)->CDSaveModelPublisher<Alarm>
    func fetchList(request:FetchAllAlarmRequestor) -> CDFetchResultPublisher<Alarm>
    func update(item:Alarm, request:UpdateAlarmRequestor)->CDSaveModelPublisher<Alarm>
    func delete(item:Alarm,request:UpdateAlarmRequestor)->CDDeleteModelPublisher<Alarm>
    func fetchEntityBy(request: UpdateAlarmRequestor)->CDFetchResultPublisher<Alarm>
}

// The data source directly talk to the data container for accessing data and return the result to repository
class AlarmLocalDataSource:AlarmLocalDataSourceProtocol,PersistentStoringProtocol {
    
    typealias T = Alarm
    var mainContext:NSManagedObjectContext
    var backgroundContext:NSManagedObjectContext
    var fetchRequest: NSFetchRequest<Alarm>?
    private var cancellable = Set<AnyCancellable>()
    
    init(mainContext:PersistenceService.Context,backgroundContext:PersistenceService.Context) {
        self.mainContext = mainContext.value
        self.backgroundContext = backgroundContext.value
    }
    func fetchList(request:FetchAllAlarmRequestor) -> CDFetchResultPublisher<Alarm> {
        self.fetchRequest = request.item
        return CDFetchResultPublisher(request: request.item, context: mainContext)
    }
    func create(request:CreateAlarmRequestor) -> CDSaveModelPublisher<Alarm> {
        let action: CoreDataSaveActionHandler<T> = {[unowned self] in
            let alarm:Alarm = self.createEntity(context: backgroundContext)
            alarm.id = UUID()
            alarm.time = request.time
            alarm.isEnabled = request.isEnabled
            return alarm
        }
        return save(backgroundContext, action)
    }
    func update(item:Alarm,request: UpdateAlarmRequestor) -> CDSaveModelPublisher<Alarm> {
        let action: CoreDataSaveActionHandler<T> = {
            item.isEnabled = request.isEnabled
            return item
        }
        return save(backgroundContext, action)
    }
    func delete(item:Alarm,request: UpdateAlarmRequestor)->CDDeleteModelPublisher<Alarm>{
        let action: CoreDataSaveActionHandler<T> = {
            return item
        }
        return erase(backgroundContext, action)
    }
    func fetchEntityBy(request: UpdateAlarmRequestor)->CDFetchResultPublisher<Alarm> {

        fetchRequest?.predicate = NSPredicate(format: "id == %@", request.id as CVarArg)
        return CDFetchResultPublisher(request: fetchRequest!, context: backgroundContext)
        
    }
}

