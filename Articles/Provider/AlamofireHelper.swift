//
//  File.swift
//  Articles
//
//  Created by Gursewak Singh on 29/10/24.
//

import UIKit
import Alamofire
import XCGLogger

////////////////////////////////////////////////////////////////
//MARK: Response Params
////////////////////////////////////////////////////////////////
enum ResponseParams: String {
    case code
    case data
    case message
}



struct AlamofireHelper {
    let log = XCGLogger.default
    // MARK: Multipart Data Uploading
    // Parameters : Pass Dictionary as parameter (String of String Type)
    // arrImages : Pass Array of UIImagesData
    typealias Completion = (_ data: Data?, _ error: Error?) -> ()
    typealias Progress = (_ progress: Double) -> ()

    // MARK: GET Request
    static func getRequest(withUrl url: String, _ headers: [String: String]? = nil, _ completion: @escaping Completion) {
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    AppDelegate.shared.log.debug("Successfully get the data from api")

                    completion(data, nil)
                case .failure(let error):
                    AppDelegate.shared.log.error("failed to get the data from api")
                    completion(nil, error)
                }
            }
    }

    // MARK: POST Request
    static func request(withUrl url: String, methodType: HTTPMethod = .post, _ param: Dictionary<String, Any>? = nil, _ headers: [String: String]? = nil, _ completion: @escaping Completion) {
        AF.request(url, method: methodType, parameters: param, encoding: JSONEncoding.default)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(data, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
}


