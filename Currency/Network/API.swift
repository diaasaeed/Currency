//
//  API.swift
//  test app 2
//
//  Created by Ahmed on 2/10/21.
//

import Foundation
import Alamofire


enum httpHeadersType{
    /// add language header
    case langOnly
    /// add authurazation header
    case   token
    /// add language and authorization
    case   both
    /// add authorization for sending notification from firebase
    case chatNotification
    /// add  no headers
    case   none
}


/// indicator appearance type
enum IndicatorType {
    /// the regular loading of the application
    case regular
    /// custome one may be added in specific request
    case custom
}
/// get the headers depends on types
/// - Parameter type: type of headers
/// - Returns: http headers
private func getHeaders(type:httpHeadersType) -> HTTPHeaders?{
    let HttpHeaders:HTTPHeaders = [ "Content-Type": "application/json"  ]
    if type == .none{
        print("No thing")
    }
    return HttpHeaders
}



extension AFError{
    var noInterNet: String{
        return "check your internet Connection"
    }
}

class APIClient: APIClientProtocol {

     private var indicatorType : IndicatorType? = .regular
    static var api = APIClient()
    /// initialize API Client Class with
    /// - Parameter indicatorType: indicator type
    init(indicatorType : IndicatorType? = .regular){
        self.indicatorType = indicatorType
    }


 //MARK: - perform request without body
    @discardableResult
    func performRequest<T>(url: String, method: HTTPMethod, completion: @escaping (Result<T, AFError>, Int?) -> Void) -> DataRequest where T : Decodable {
        if self.indicatorType == .regular {
//            Indicator.shared.showProgressView()
        }
        
        
        return AF.request(url, method: method, parameters: nil, encoding: JSONEncoding.default, headers: getHeaders(type: .none)).responseDecodable (decoder: JSONDecoder()){ (response: DataResponse<T, AFError>) in

            if self.indicatorType == .regular {
//                Indicator.shared.hideProgressView()
            }

            debugPrint(response)
            completion(response.result, response.response?.statusCode)
        }
    }
     
}



protocol APIClientProtocol: AnyObject{

    /// perform reguler request without parameters
    /// - Parameters:
    ///   - url: API URL
    ///   - method: HTTP Method
    ///   - headersType: HTTP headers
    ///   - indicatorType: custom control of loading style
    ///   - completion: clusure to excute
    ///   - result : the result of decoded Model and error
    ///   - statusCode: the API statusCode
    /// - Returns: Alamofire Request
    @discardableResult
    func performRequest<T:Decodable>(url: String, method: HTTPMethod , completion:@escaping (_ result: Result<T, AFError>,_ statusCode:Int?)->Void) -> DataRequest

}
