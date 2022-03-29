//
//  ExploreFilterModel.swift
//  ABOAcademy
//
//  Created by Shrinivas Reddy on 11/03/22.
//

import Foundation

struct ExploreFilterModel: Hashable, Equatable {
    
    var category : String = ""
    var subCategory : [SubCategory] = []
    
    init() {}
    
    init(response : [String : Any]) {
        
        if let category = response["category"] as? String {
            self.category = category
        }
        
        if let subCategory = response["subCategory"] as? [[String : Any]] {
            for item in subCategory {
                let object = SubCategory(response: item)
                self.subCategory.append(object)
            }
        }
    }
}

struct SubCategory: Hashable, Equatable {
    
    var id : Int = -1
    var title : String = ""
    var count : Int = 0
    
    var isMarked : Bool = false
    
    init() {}
    
    init(response : [String : Any]) {
        
        if let id = response["id"] as? Int {
            self.id = id
        }
        
        if let title = response["title"] as? String {
            self.title = title
        }
        
        if let count = response["count"] as? Int {
            self.count = count
        }
        
        if let isMarked = response["isMarked"] as? Bool {
            self.isMarked = isMarked
        }
    }
}

