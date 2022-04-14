//
//  API.swift
//  test app 2
//
//  Created by Ahmed on 2/10/21.
//

import Foundation
import Alamofire
   
extension AFError{
    var noInterNet: String{
        return "check your internet Connection"
    }
}

class APIClient {
     static let shared = APIClient()
    private init() { }

    func getData<T: Decodable>(url: String, method: HTTPMethod ,params: Parameters?, encoding: ParameterEncoding ,headers: HTTPHeaders? ,completion: @escaping (T?,Int, Error?)->()) {
        
        AF.request(url, method: method, parameters: params , encoding: encoding, headers: headers)
            .validate(statusCode: 200...300)
            .responseJSON { (response) in
//                print("parameters",params)
                print("Status code ->",response.response?.statusCode ?? 0)
                switch response.result {
                case .success(_):
                    print("Responce ",response.value)
                    guard let data = response.data else { return }
                    do {
                        let jsonData = try JSONDecoder().decode(T.self, from: data)
                        completion(jsonData,response.response?.statusCode ?? 0, nil)
                        
                    } catch let jsonError {
                        print(jsonError.localizedDescription)
                    }
                    
                case .failure(let error):
                    // switch on Error Status Code
                    print(error.localizedDescription)
                    guard let data = response.data else { return }
                    guard let statusCode = response.response?.statusCode else { return }
                    print("Status code ->",response.response?.statusCode ?? 0)
                    switch statusCode {
                    case 400..<500:
                        do {
                            let jsonError = try JSONDecoder().decode(T.self, from: data)
                            completion(jsonError,response.response?.statusCode ?? 0, nil)
                            
                        } catch let jsonError {
                            print(jsonError)
                        }
                    default:
                        completion(nil,response.response?.statusCode ?? 0, error)
                    }
                }
            }
    }
    
}

 
