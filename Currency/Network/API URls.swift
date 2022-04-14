//
//  API URls.swift
//  test app 2
//
//  Created by Ahmed on 2/10/21.
//

import Foundation

//MARK: - constant
let access_key = "f84f6e05483fc918ccd604496a6ec406"



class URls{
   static let shared = URls()
    
    lazy var Domain = "http://data.fixer.io/api/"
    lazy var latest = "\(Domain)latest"
    
    
}

