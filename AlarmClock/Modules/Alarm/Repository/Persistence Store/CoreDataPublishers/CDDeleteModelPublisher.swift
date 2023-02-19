//
//  CDDeleteModelPublisher.swift
//  AlarmClock
//
//  Created by Linkon Sid on 30/1/23.
//

import Combine
import CoreData

// this publisher provides entity saving mechanism to core data
struct CDDeleteModelPublisher<T:NSManagedObject>:Publisher{
    typealias Output = Bool
    typealias Failure = PersistenceFailure
    private let action: CoreDataSaveActionHandler<T>
    private let context: NSManagedObjectContext
    
    init(action: @escaping CoreDataSaveActionHandler<T>, context: NSManagedObjectContext) {
        self.action = action
        self.context = context
    }
    func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        let subscription = Subscription(subscriber: subscriber, context: context, action: action)
        subscriber.receive(subscription: subscription)
    }
    
}

extension CDDeleteModelPublisher{
    class Subscription<S> where S:Subscriber, Failure == S.Failure, Output == S.Input,T:NSManagedObject{
        private var subscriber: S?
        private let action: CoreDataSaveActionHandler<T>
        private let context: NSManagedObjectContext
        
        init(subscriber: S, context: NSManagedObjectContext, action: @escaping CoreDataSaveActionHandler<T>) {
            self.subscriber = subscriber
            self.context = context
            self.action = action
            
        }
        private func saveContext() throws{
            if context.hasChanges {
                do {
                    try context.save()
                } catch (let error){
                    throw error
                }
            }
        }
    }
}

extension CDDeleteModelPublisher.Subscription:Subscription{
    func cancel() {
        subscriber = nil
    }
    
    func request(_ demand: Subscribers.Demand) {
        var demand = demand
        guard let subscriber = subscriber, demand > 0 else {
            subscriber?.receive(completion: .failure(.ServiceNotAvailable))
            return
        }
        let result = action()
        demand -= 1
        do{
            guard let data = result else{
                subscriber.receive(completion: .failure(.DataHandlingError))
                return
            }
            context.delete(data)
            try self.saveContext()
            demand += subscriber.receive(true)
            subscriber.receive(completion: .finished)
        }
        catch let error{
            print(error.localizedDescription)
            subscriber.receive(completion: .failure(.FailedToSave))
        }
        
    }
}
