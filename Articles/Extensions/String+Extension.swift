//
//  String+Extension.swift
//  Articles
//
//  Created by Gursewak Singh on 30/10/24.
//

import Foundation
extension String {
    func toFormattedDateString() -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        inputFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMM d, yyyy" // Format like "Jan 7, 2024"
            return outputFormatter.string(from: date)
        } else {
            return nil // Return nil if the input string is not a valid date
        }
    }
}
