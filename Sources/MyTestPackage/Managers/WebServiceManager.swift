//
//  WebServiceManager.swift
//  ABOAcademy
//
//  Created by Shrinivas Reddy on 27/12/21.
//

import Foundation
import Alamofire
import Amway_Base_Utility

enum ServiceType {
    
    case FetchServiceAccessToken
}

typealias ServiceRequestSuccessBlock  = (_ result:Any) -> Void
typealias ServiceRequestFailureBlock  = (_ failurError:NSError) -> Void
typealias ServiceRequestOfflineBlock  = (_ offline:NSError) -> Void

// Manages the service calls throughout the app

class WebServiceManager : NSObject {
    
    static var shared = WebServiceManager()
    weak var alamofireManager : AlamofireManager? = AlamofireManager.shared
    
    private override init() {
        super.init()
    }
    
    func sendRequest(serviceType : ServiceType,
                     url : String,
                     headers : [String : Any],
                     params : [String : Any],
                     success: @escaping ServiceRequestSuccessBlock,
                     failure: @escaping ServiceRequestFailureBlock,
                     offline: @escaping ServiceRequestOfflineBlock){
        
        // Provision for custom tokens
        let accessToken = ""
        print("SERVICE TYPE IS - \(serviceType)")
        
        switch serviceType {
        
        case .FetchServiceAccessToken:
            sendAccessTokenRequest(url : url, headers: headers, accessToken: accessToken, serviceType: serviceType, params: params, success: success, failure: failure, offline: offline)
        }
    }
    
    
    //MARK:- Token Requests
    
    // Fetch Access Token
    //
    private func sendAccessTokenRequest(url: String, headers: [String : Any], accessToken : String, serviceType : ServiceType, params: [String : Any], success: @escaping ServiceRequestSuccessBlock, failure: @escaping ServiceRequestFailureBlock, offline: @escaping ServiceRequestOfflineBlock) {
        
        let header : [String : String] = headers as! [String : String]
        let url = Amway_Base_Utility.CommonUtils.getURLFromString(urlString: url)
        let httpHeaders = HTTPHeaders.init(header)
        
        alamofireManager?.makeAPIRequest(urlRequest: url, parameters: params, methodType: .post, encodingType: URLEncoding.default, headers: httpHeaders, success: { (response) in
            
            /*
            // Save Token into Keychain & Token Manager
            TokenManager.shared.saveAccessTokenToKeychain(response: response , key: APIConstants.keys.keychainIDForTokens)*/
            success(response)
            
        }) { (error) in
            failure(error as NSError)
        }
    }
}
