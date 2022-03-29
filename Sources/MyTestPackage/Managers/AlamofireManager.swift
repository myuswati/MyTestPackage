//
//  AlamofireManager.swift
//  ABOAcademy
//
//  Created by Shrinivas Reddy on 27/12/21.
//

import Foundation
import Alamofire

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}

class AlamofireManager : NSObject {
    
    static let shared = AlamofireManager()
    private let alamofireManager : Alamofire.Session
    
    let unAuthorizedError = NSError(domain: "UnAuthorized", code: 401, userInfo: nil)
    let badRequestError = NSError(domain: "BadRequest", code: 400, userInfo: nil)
    let serverError = NSError(domain: "InternalServerError", code: 500, userInfo: nil)
        
    private override init() {
        
        /// Set the custom configuration for service timeouts
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 60
        configuration.timeoutIntervalForRequest = 60
        self.alamofireManager = Alamofire.Session(configuration: configuration)
        
// SSL pining basic integration
//        let secKey = Utils.getSecKeyFromString(keyBase64: "SSH Key to Pass")
//        let elevator = PublicKeysTrustEvaluator(keys: [secKey], performDefaultValidation: true, validateHost: true)
//
//        let evaluators: [String: ServerTrustEvaluating] = [
//            "*.com": elevator
//        ]
//
//        let manager = ServerTrustManager(evaluators: evaluators)
//
//        self.alamofireManager  = Session(serverTrustManager: manager)
        
    }
    
    
    //MARK:- METHODS
    /// Make an API Call and get Dictionary/Error as a response from Success/Failure callbacks
    ///
    /// - Parameters:
    ///   - url: URL in String
    ///   - parameters: Dictionary [String: Any]
    ///   - methodType: .get, .post, .delete
    ///   - headers: Dictionary [String: Any]
    ///   - success: Success callback returning dictionary [String : Any]
    ///   - failure: Failure callback returning Error
    
    
    func makeAPIRequest(urlRequest : String, parameters : Parameters?, methodType : Alamofire.HTTPMethod, encodingType : ParameterEncoding,  headers : HTTPHeaders?,
                        success : @escaping ([String : Any]) -> Void, failure : @escaping (Error) -> Void) {
        
        
        //let urlRequest = urlRequest.URLRequest as URLRequest
        print("\n----- REQUEST ------")
        print("\nURL : \(urlRequest)")
        print("\nHEADERS : \(headers ?? HTTPHeaders.init([:]))")
        print("\nPARAMETERS : \(parameters ?? [:])")
        
        alamofireManager.request(urlRequest, method: methodType, parameters: parameters, encoding: encodingType, headers: headers).responseJSON { [weak self] (response) in
            
            print("\n----- RESPONSE ------")
            print("\nSTATUS_CODE : \(response.response?.statusCode ?? -1001)")
            print("\nURL : \(urlRequest)")
            print("\nPARAMETERS : \(parameters ?? [:])")
            print("\nRESPONSE : \(response)")
            print("\n----- RESPONSE END ------\n")
            let defaultError = NSError.init(domain: "default error", code: 400, userInfo: nil)
            
            guard let statusCode = response.response?.statusCode else {
                print("Cannot cast Status code")
                failure(self?.badRequestError ?? defaultError)
                return
            }
            
            // Handle Error cases
            switch statusCode {
                
            case 401, 403 :
                // Refresh the token if unauthorized
                //
                /*OktaSessionManager.shared.renewTokens {

                    // Recall the same flow
                    // Update the headers
                    var headersDict = headers!.dictionary
                    headersDict.updateValue("Bearer \(OktaSessionManager.shared.stateManager?.accessToken ?? "RENEWD_TOKEN")", forKey: "Authorization")
                    
                    print("HEADERS AFTER UPDATING THE REFRESHING TOKEN ")
                    headersDict.printJson()
                    
                    self?.makeAPIRequest(urlRequest: urlRequest, parameters: parameters, methodType: methodType, encodingType: encodingType, headers: HTTPHeaders.init(headersDict), success: success, failure: failure)
                } failure: {
                    // Navigate user back to login flow
                    //
                    // Revoke the Tokens
                    print("Refreshing Token failed in AlamofireManager")
                    OktaSessionManager.shared.revokeTokens()
                    failure(self?.unAuthorizedError ?? defaultError)
                }

                //failure(self?.unAuthorizedError ?? defaultError)
                 */
                return
            case 400..<500 :
                failure(self?.badRequestError ?? defaultError)
            case 500:
                failure(self?.serverError ?? defaultError)
                return
                
            default:
                print("")
            }
            
            switch response.result {
                
            case .success(let value) :
                
                guard let statusCode = response.response?.statusCode else {
                    print("NO STATUS CODE PRESENT!! RETURNING!! ")
                    return
                }
                
                switch statusCode {
                    
                case 200..<300 :
                    if let responseDict = value as? [String : Any] {
                        success(responseDict)
                    }
                default :
                    failure(self?.badRequestError ?? defaultError)
                }
                
            case .failure(let error) :
                print("AlamofireManagerError : \(error.localizedDescription)")
                failure(error)
            }
        }
    }
}
