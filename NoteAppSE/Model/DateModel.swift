//
//  DateModel.swift
//  NoteAppSE
//
//  Created by Stanislav on 30.06.2021.
//

import Foundation

class DateModel {
    var dateService: DateServiceProtocol

    init(dateService: DateServiceProtocol) {
        self.dateService = dateService
    }

    func getDate() -> String {
        return dateService.getCurrentDate()
    }
}
