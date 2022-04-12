//
//  NetworkCheck.swift
//  PIL
//
//  Created by Ahmed on 11/4/21.
//

import Foundation
import Network

@available(iOS 13.0, *)
public class InterNet{
    
    /// shared inistance of internet class
    static var shared: InterNet{
        let inistance = InterNet()
        return inistance
    }
    
    /// check internet connictivity
    func checkInternet(compilition: @escaping ((_ avaliable: Bool) -> Void)) {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied{
                compilition(true)
            } else {
                compilition(false)
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
    }
}
