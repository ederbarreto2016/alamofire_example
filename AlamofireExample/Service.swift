//
//  Service.swift
//  AlamofireExample
//
//  Created by Éder Barreto on 23/05/21.
//

import Foundation
import Alamofire

class Service {
    
    fileprivate var baseUrl = ""
    typealias countriesCallBack = (_ countries: [Country]?, _ status: Bool, _ message: String) -> Void
    
    var callBack: countriesCallBack?
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func getAllCountryNameFrom(endpoint: String){
        AF.request(self.baseUrl + endpoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (responseData) in
            guard let data = responseData.data else {
                self.callBack?(nil, false, "")

                return}
            do {
                let countries  = try JSONDecoder().decode([Country].self, from: data)
                self.callBack?(countries, true, "")
            } catch {
                self.callBack?(nil, false, error.localizedDescription)
            }
        }
    }
    
    func completionHandler(callBack: @escaping countriesCallBack) {
        self.callBack = callBack
    }
}
