//
//  File.swift
//  Articles
//
//  Created by Gursewak Singh on 29/10/24.
//

////////////////////////////////////////////////////////////////
//This Code supports Alamofire 4.0+
////////////////////////////////////////////////////////////////

import UIKit
import Alamofire

////////////////////////////////////////////////////////////////
//MARK: Response Params
////////////////////////////////////////////////////////////////
enum ResponseParams: String {
    case code
    case data
    case message
}

////////////////////////////////////////////////////////////////
//MARK: API Manager
///Manage all your API Listing here!
////////////////////////////////////////////////////////////////
struct API {
    fileprivate static let BASE_URL = "https://mocki.io/v1/"
    static let GET_ARTICLES = BASE_URL + "e91eafa6-46f7-4bd1-87f7-2770c7b7e194"
    
}

////////////////////////////////////////////////////////////////
//MARK: This is specially to manage Background Task
////////////////////////////////////////////////////////////////
class Networking {
    static let sharedInstance = Networking()
    public var sessionManager: Alamofire.SessionManager // most of your web service clients will call through sessionManager
    public var backgroundSessionManager: Alamofire.SessionManager // your web services you intend to keep running when the system backgrounds your app will use this
    private init() {
        self.sessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
        self.backgroundSessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.background(withIdentifier: "com.Articles"))
        var backgroundCompletionHandler: (() -> Void)? {
            get {
                return backgroundSessionManager.backgroundCompletionHandler
            }
            set {
                backgroundSessionManager.backgroundCompletionHandler = newValue
            }
        }
    }
}

////////////////////////////////////////////////////////////////
//MARK: AlamofireHelper : To manage All type of requests
////////////////////////////////////////////////////////////////


struct AlamofireHelper {

    // MARK: Multipart Data Uploading
    // Parameters : Pass Dictionary as parameter (String of String Type)
    // arrImages : Pass Array of UIImagesData
    typealias Completion = (_ data: Data?, _ error: Error?) -> ()
    typealias Progress = (_ progress: Double) -> ()

    // MARK: GET Request
    static func getRequest(withUrl url: String, _ headers: [String: String]? = nil, _ completion: @escaping Completion) {
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(data, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }

    // MARK: POST Request
    static func request(withUrl url: String, methodType: HTTPMethod = .post, _ param: Dictionary<String, Any>? = nil, _ headers: [String: String]? = nil, _ completion: @escaping Completion) {
        Alamofire.request(url, method: methodType, parameters: param, encoding: JSONEncoding.default, headers: headers)
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

extension String {
    func toFormattedDateString() -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        inputFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMM d, yyyy" // Format like "Jan 7, 2024"
            return outputFormatter.string(from: date)
        } else {
            return nil // Return nil if the input string is not a valid date
        }
    }
}
