//
//  Task+CoreDataProperties.swift
//  NoteAppSE
//
//  Created by Stanislav on 21.11.2021.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var nameTask: String?
    @NSManaged public var colorTask: String?
    @NSManaged public var completedTask: Bool
    @NSManaged public var groupList: Group?
    @NSManaged public var descriptionTask: String?

}

extension Task : Identifiable {

}
