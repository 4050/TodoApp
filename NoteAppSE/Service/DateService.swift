//
//  DateService.swift
//  NoteAppSE
//
//  Created by Stanislav on 30.06.2021.
//

import Foundation

protocol DateServiceProtocol {
    func getCurrentDate() -> String
}

class DateService: DateServiceProtocol {

    private var calendar = Calendar.current
    private let date = Date()
    
   func getCurrentDate() -> String {
        let componentsFromCurrentDate = calendar.dateComponents([.month, .day], from: date)
        let nameMonth = Calendar.current.monthSymbols
        let currentMonth: String = nameMonth[componentsFromCurrentDate.month! - 1]
        let currentDay: String = String(componentsFromCurrentDate.day!)
        let currentDate = "\(currentMonth) \(currentDay)"
        return currentDate
    }
}
