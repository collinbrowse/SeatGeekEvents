//
//  Date+Ext.swift
//  FetchRewardsCodingExercise
//
//  Created by Collin Browse on 1/7/21.
//

import Foundation


extension Date {
    
   func getFormattedDate(format: String) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        return dateformatter.string(from: self)
    }
}
