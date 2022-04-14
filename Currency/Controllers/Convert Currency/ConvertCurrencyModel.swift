//
//  ConvertCurrencyModel.swift
//  Currency
//
//  Created by Diaa saeed on 4/12/22.
//

import Foundation
class ConvertCurrencyModel:Codable{
    var success: Bool?
    var timestamp: Int?
    var base, date: String?
    var rates: [String: Double]?
    var error:ErrorModel?
}


struct ErrorModel : Codable {
    var code: Int?
    var type: String?
}


class CountryCurrency{
    var country:String?
    var currency:Double?
}


class MyConvertCurrencyOBJ{
    var fromCurrency:Double?
    var fromCountry:String?
    var toCurrency:Double?
    var toCounrty:String?
    var amount:Double?
}

