//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Alejandro Cervantes on 2024-05-06.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
