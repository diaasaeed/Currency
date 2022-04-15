//
//  API URls.swift
//  test app 2
//
//  Created by Ahmed on 2/10/21.
//

import Foundation

//MARK: - constant
let access_key = "bf07e635f6d48c9a96cafd5cc15cc035"



class URls{
   static let shared = URls()
    
    lazy var Domain = "http://data.fixer.io/api/"
    lazy var latest = "\(Domain)latest"
    
    
}

