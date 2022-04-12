//
//  StringEX.swift
//  Nazan
//
//  Created by apple on 6/23/20.
//  Copyright © 2020 Atiaf. All rights reserved.
//

import Foundation
var app_lang = "en"

extension String {
    
    /**
     get the localized value of the string key
     */
    var localized: String {
        let localizedString = NSLocalizedString(self, comment: "")
        return localizedString
    }
    
    /**
     check the string is a valid email or not with reguler expression
     */
    var checkEmail: Bool{
        let range = NSRange(location: 0, length: self.utf8.count)
        let rgex = try! NSRegularExpression(pattern: "[a-zA-Z0-9]*@[a-zA-Z]+.[a-zA-Z]{1,3}")
        return rgex.firstMatch(in: self, options: [], range: range) != nil
    }
    
    /**
     check the time string is a empty or not
     */
    var getTime: String{
        if self == ""{
            return "00:00"
        }else{
            return self
        }
    }
    
    /// convert selected string to any date
    /// - Parameters:
    ///   - currentFormate: the formate of the current date string
    ///   - expectedFormate: the formate of the current date string that youy want to formate date to
    /// - Returns: formated date
    func getDateString(currentFormate: String , expectedFormate: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currentFormate
        dateFormatter.locale = NSLocale(localeIdentifier: "en") as Locale
        if let currentDateStr = dateFormatter.date(from: self){
            dateFormatter.dateFormat = expectedFormate
            dateFormatter.locale = NSLocale(localeIdentifier: app_lang) as Locale
            let expectedDateStr = dateFormatter.string(from: currentDateStr)
            return expectedDateStr
        }
        
        return ""
    }
    
    
    /// create query Parameters
    /// - Parameters:
    ///   - queries: queries list
    /// - Returns: api url string contaned query parameters
    func addQueryParameters(queries: [URLQueryItem]) -> String{
        var urlComps = URLComponents(string: self)!
        urlComps.queryItems = queries
        return "\(urlComps.url!)"
    }
    
    /// take the club full name and sub string to short cut
    /// ```
    /// take the string and split it according to white space
    /// and if the words more than one word take the first char of every word to be the shortcut
    /// and if the full name is one word take the first 3 char to be the shortcut
    /// ```
    /// - example:- "Barchelona" --> "Bar"
    /// - exmple:- "Real Madrid" --> "RM"
    /// 
    /// - Parameter name: full name of the club
    /// - Returns: return the shortcut that descripe that club name
    var shortcut: String{
        let nameParts = self.components(separatedBy: " ")
        if nameParts.count == 1{
            if self.count <= 3{
                return self
            }else{
               return String(self.prefix(3))
            }
        }else{
            var shortCut = ""
            nameParts.forEach { (word) in
                shortCut+=String(word.prefix(1))
            }
            return shortCut
        }
    }
    
    /// convert selected string to any date
    /// - Parameters:
    ///   - currentFormate: the formate of current date string
    ///   - lang: the language that you want to convert from it
    /// - Returns: date for dataType Date
    func getDate(currentFormate: String, from lang: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currentFormate
        dateFormatter.locale = NSLocale(localeIdentifier: lang) as Locale
        let currentDateStr = dateFormatter.date(from: self)
        return currentDateStr ?? Date()
    }
    
    func getDateUTC(currentFormate: String, from lang: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currentFormate
        dateFormatter.locale = NSLocale(localeIdentifier: lang) as Locale
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let currentDateStr = dateFormatter.date(from: self)
        return currentDateStr ?? Date()
    }
    
    /// localize selected date string
    /// - Parameter currentFormate: the formate of current date string
    /// - Returns: return localizedstring depends on app language
    func formateDate(currentFormate: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currentFormate
        dateFormatter.locale = NSLocale(localeIdentifier: "en") as Locale
        if let currentDateStr = dateFormatter.date(from: self){
            dateFormatter.dateFormat = currentFormate
            dateFormatter.locale = NSLocale(localeIdentifier: app_lang) as Locale
            let expectedDateStr = dateFormatter.string(from: currentDateStr)
            return expectedDateStr
        }
        return ""
    }
    
    /**
     make string formated as 2 digits after float point
     */
    var getPrice:String{
        let doublePrice = Double(self) ?? 0.0
        return String(format: "%.1f", doublePrice)
    }
    
    /**
     check if the string is empty to return NA
     */
    var checkEmpty:String{
        return self.isEmpty ? "NA":self
    }
    
    /**
     variable to make the string is a valid url query string
     */
    var getUrlPath:String{
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
 
    
    /// encrypt phone number of players
    var encrypt: String{
        var charList: [String] = self.map{ String($0) }
        let startRange = 0..<3
        let endRange = charList.count-3..<charList.count-0
        for item in charList.enumerated(){
            if !(startRange.contains(item.offset) || endRange.contains(item.offset)){
                charList[item.offset] = "*"
            }
        }
        return charList.joined()
    }
}


extension Date{
    
    func toString(withFormat format: String = "dd/MM EEEE , a") -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = NSLocale.current
        dateFormatter.timeZone = TimeZone.current //Set timezone that you want
        let str = dateFormatter.string(from: self)
        
        return str
    }
    
    
    func toStringForrmater(withFormat format: String ) -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)

        return str
    }

    
}
