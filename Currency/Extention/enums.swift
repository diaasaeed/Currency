//
//  enums.swift
//  employee
//
//  Created by Ahmed on 2/16/21.
//

import Foundation


//MARK: - errors
/// the standard validations error types
enum errors: String{
    case empty = "Empty",
         weakPass = "Weak password",
         invalidEmail = "Invalid Email",
         passwordMisMatch = "passMisMatch",
         invalidCode = "invalidCode",
         imgsEmpty = "imgInvalid",
         invalidDate = "invalidDate",
         invalidTimePeriod = "invalidTime",
         policyAgree = "policyAgree",
         invalidPass = "passInvalid"
}

/// the standard API statuscode error types
enum APIErrors{
    case Badrequest,
         ServerError,
         UnKnownError(_ errorStr: String),
         noInternet
    
    /// get the error description localized
    var localizedErrorDescription: String{
        switch self{
        case .Badrequest: return "Bad request".localized
        case .ServerError: return "Server error".localized
        case .UnKnownError(let error): return error
        case.noInternet: return "no Internet".localized
        }
    }
}
 

 
 
