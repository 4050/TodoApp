//
//  GroupListModel.swift
//  NoteAppSE
//
//  Created by Stanislav on 27.06.2021.
//

import Foundation

struct CategoryModel {
    var nameCategory: String?
    var numberTasks: Int16?
    var colorCategory: String?
    var taskList: NSSet?
    
    var storageService = StorageService()
    
    func getCategoryList() -> [Group] {
        let list = storageService.getGroupTasks()
        return list
    }
    
    func saveGroup(category: CategoryModel) {
        storageService.saveGroupTasks(category: category)
    }
    
}

struct TaskModel {
    var taskName: String?
    var colorCell: String?
    var completedTask: Bool?
    var parentCategory: Group?
    
    var storageService = StorageService()
    
    init(taskName: String? = nil, colorCell: String? = nil, completedTask: Bool? = nil, parentCategory: Group? = nil) {
        self.taskName = taskName
        self.colorCell = colorCell
        self.completedTask = completedTask
        self.parentCategory = parentCategory
    }
    
    func getTaskList() -> [Task] {
        let list = storageService.getTasks()
        return list
    }
    
    func saveTask(colorTask: String, completedTask: Bool, nameTask: String, groupTask: Group) {
        storageService.saveTask(colorTask: colorTask, completedTask: completedTask, nameTask: nameTask, groupTask: groupTask)
    }
    
}


