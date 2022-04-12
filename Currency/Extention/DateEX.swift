//
//  DateEX.swift
//  Al Senaiah
//
//  Created by apple on 11/30/20.
//

import UIKit

extension Date {
    
    /// convert date to unixtimestamp
    /// - Returns: teh unixtimestamp of selected date
    func TotimeStamp() -> Int64 {
        return Int64(self.timeIntervalSince1970)
    }
    
    /// get the year of the selected date
    /// - Returns: the year of selected date
    func Year() -> Int {
         let year = Calendar.current.component(.year, from: self)
         return year
     }
    
    /// get the month of the selected date
    /// - Returns: the month of selected date
    func Month() -> Int {
         let month = Calendar.current.component(.month, from: self)
         return month
     }
 
    
    
    func getTimeTo(date: Date) -> String{
        var timeLeft = ""
        let timeLeftComponents = Calendar.current.dateComponents([.hour, .minute], from: date, to: Date())
        if timeLeftComponents.hour != 0{
            timeLeft += "\(timeLeftComponents.hour ?? 0) H,"
        }
        
        if timeLeftComponents.minute != 0{
            timeLeft += "\(timeLeftComponents.minute ?? 0) min"
        }
        
        if timeLeftComponents.hour == 0 && timeLeftComponents.minute == 0{
            timeLeft = "just now"
        }
        
        return timeLeft
    }
}


