//
//  API URls.swift
//  test app 2
//
//  Created by Ahmed on 2/10/21.
//

import Foundation

//MARK: - constant
let access_key = "8591ad00b7ccb159cf9a459c06807197"



class URls{
   static let shared = URls()
    
    lazy var Domain = "http://data.fixer.io/api/"
    lazy var latest = "\(Domain)latest"
    
    
}

