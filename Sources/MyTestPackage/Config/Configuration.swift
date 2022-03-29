//
//  Configuration.swift
//  ABOAcademy
//
//  Created by Shrinivas Reddy on 21/12/21.
//

import Foundation

enum Configuration: String {

    // MARK: - Configurations

    case test
    case dev
    case prod
    case stage

    // MARK: - Current Configuration
    static let current: Configuration = {
        guard let rawValue = Bundle.main.infoDictionary?["Configuration"] as? String else {
            fatalError("No Configuration Found")
        }

        guard let configuration = Configuration(rawValue: rawValue.lowercased()) else {
            fatalError("Invalid Configuration")
        }

        return configuration
    }()
    
    //TODO: - Add the base URLs here for different envs
    // MARK: - Base URL
    /*static var baseURL: URL {
        switch current {
        case .dev:
            return URL(string: "")!
        case .test:
            return URL(string: "")!
        case .stage:
            return URL(string: "")!
        case .prod:
            return URL(string: "")!
        }
    }*/
    
    

}
