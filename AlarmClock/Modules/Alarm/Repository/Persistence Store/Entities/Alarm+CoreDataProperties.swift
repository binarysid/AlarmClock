//
//  Alarm+CoreDataProperties.swift
//  HugeClock
//
//  Created by Linkon Sid on 28/1/23.
//
//

import Foundation
import CoreData


extension Alarm {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Alarm> {
        return NSFetchRequest<Alarm>(entityName: "Alarm")
    }

    @NSManaged public var time: Date
    @NSManaged public var isEnabled: Bool
    @NSManaged public var id: UUID

}

extension Alarm : Identifiable {

}
