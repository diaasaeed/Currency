//
//  Protocol.swift
//  Currency
//
//  Created by Diaa saeed on 4/13/22.
//

import Foundation
/// protocol used for error condion from API
@objc protocol ErrorProtocol: AnyObject{
    
    /// impelimentation for API from errors
    /// - Parameter error: error message description
    func featching(error: String)
    
    /// session of the user is expired and need to login again
    @objc optional func sessionExpired()
}
