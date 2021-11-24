//
//  Group+CoreDataProperties.swift
//  NoteAppSE
//
//  Created by Stanislav on 21.11.2021.
//
//

import Foundation
import CoreData


extension Group {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Group> {
        return NSFetchRequest<Group>(entityName: "Group")
    }

    @NSManaged public var nameGroup: String?
    @NSManaged public var colorGroup: String?
    @NSManaged public var numberTask: Int16
    @NSManaged public var taskList: NSSet?

}

// MARK: Generated accessors for taskList
extension Group {

    @objc(addTaskListObject:)
    @NSManaged public func addToTaskList(_ value: Task)

    @objc(removeTaskListObject:)
    @NSManaged public func removeFromTaskList(_ value: Task)

    @objc(addTaskList:)
    @NSManaged public func addToTaskList(_ values: NSSet)

    @objc(removeTaskList:)
    @NSManaged public func removeFromTaskList(_ values: NSSet)

}

extension Group : Identifiable {

}
