//
//  GroupListModel.swift
//  NoteAppSE
//
//  Created by Stanislav on 27.06.2021.
//

import Foundation

struct GroupListModel {
    var nameGroup: String?
    var numberTasks: String?
    var colorCell: String?
    var taskList: [TaskModel]?
}

struct TaskModel {
    var taskName: String?
}

