//
//  API URls.swift
//  test app 2
//
//  Created by Ahmed on 2/10/21.
//

import Foundation

class URls{
   static let shared = URls()
    
    lazy fileprivate var Domain = "http://data.fixer.io/api/"
    lazy var latest = "\(Domain)latest"
    
    
}

