//
//  Date+Ext.swift
//  Github Followers
//
//  Created by Muhammad Afif Maruf on 17/02/24.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MMM yyyy"
        return dateformatter.string(from: self)
    }
}
