//
//  DoubleEX.swift
//  employee
//
//  Created by Ahmed on 3/7/21.
//

import Foundation


extension Double{
    
    /// formate long double value to just two digits after the point
    /// Example: 12.455457645647 => 12.45
    var getTwoDigits:Double{
        return Double(String(format: "%.2f", self)) ?? 0.0
    }
}
