//
//  encodableEX.swift
//  Q_managment
//
//  Created by Ahmed on 6/28/21.
//

import Foundation

extension Encodable{
    
    /// encode class that confirm Encodable to Data to send it to HTTP body
    var encode : Data?{
        do {
            return try JSONEncoder().encode(self)
        }catch{
            return nil
        }
    }
}
