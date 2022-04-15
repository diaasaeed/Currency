//
//  API URls.swift
//  test app 2
//
//  Created by Ahmed on 2/10/21.
//

import Foundation

//MARK: - constant
let access_key = "324b265731654012314a664a2800e3c2"



class URls{
   static let shared = URls()
    
    lazy var Domain = "http://data.fixer.io/api/"
    lazy var latest = "\(Domain)latest"
    
    
}

