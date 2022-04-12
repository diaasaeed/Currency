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
}

