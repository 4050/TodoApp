//
//  StorageService.swift
//  NoteAppSE
//
//  Created by Stanislav on 14.11.2021.
//

import Foundation
import CoreData

class StorageService {
    
    static let shared = StorageService()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskModel")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    lazy var backgroundMOC = persistentContainer.newBackgroundContext()
    
    func getGroupTasks() -> [Group] {
        context.automaticallyMergesChangesFromParent = true
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Group")
        do {
            guard let fetchedObjects =
                    try context.fetch(fetchRequest) as? [Group] else { return [Group]() }
            print("fetch:\(fetchedObjects)")
            return fetchedObjects
        } catch {
            print(error.localizedDescription)
            return [Group()]
        }
    }
    
    func getTasks() -> [Task] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do {
            guard let fetchedObjects =
                    try context.fetch(fetchRequest) as? [Task] else { return [Task]() }
            print("FETCHEDOBJECT:\(fetchedObjects)")
            return fetchedObjects
        } catch {
            print(error.localizedDescription)
            return [Task()]
        }
    }
    
    func saveGroupTasks(category: CategoryModel) {
        let taskObject = NSEntityDescription.insertNewObject(forEntityName: "Group", into: context) as! Group
        backgroundMOC.performAndWait {
            taskObject.setValue(category.nameCategory, forKey: "nameGroup")
            taskObject.setValue(category.colorCategory, forKey: "colorGroup")
            do {
                try context.save()
                print("Save")
            } catch {
                print(error)
            }
        }
    }
    
    func saveTask(colorTask: String, completedTask: Bool, nameTask: String, groupTask: Group) {
        let taskObject = NSEntityDescription.insertNewObject(forEntityName: "Task", into: context) as! Task
        backgroundMOC.performAndWait {
            taskObject.nameTask = nameTask
            taskObject.completedTask = completedTask
            taskObject.colorTask = colorTask
            taskObject.groupList = groupTask
            do {
                try context.save()
                print("Save")
            } catch {
                print(error)
            }
        }
    }
    
    func updateTask(colorTask: String? = nil, completedTask: Bool? = nil, nameTask: String? = nil, groupTask: Group? = nil, parameter: Parametеrs) {
        let taskObject = Task(context: context)
        backgroundMOC.performAndWait {
            switch(parameter) {
            case .nameTask:
                taskObject.nameTask = nameTask
            case .colorTask:
                taskObject.colorTask = colorTask
            case .completedTask:
                taskObject.completedTask = completedTask ?? false
            case .groupTask:
                taskObject.groupList = groupTask
            }
            do {
                try context.save()
                print("Save")
            } catch {
                print(error)
            }
        }
    }
    
    func deleteCategory(category: Group) {
        backgroundMOC.performAndWait {
            context.delete(category)
            do {
                try context.save()
                print("Save")
            } catch {
                print(error)
            }
        }
    }
    
    func deleteTask(task: Task) {
        backgroundMOC.performAndWait {
            context.delete(task)
            do {
                try context.save()
                print("Save")
            } catch {
                print(error)
            }
        }
    }
}
