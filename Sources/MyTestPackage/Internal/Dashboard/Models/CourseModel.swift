//
//  CourseModel.swift
//  ABOAcademy
//
//  Created by Swapnil Tilkari on 11/02/22.
//

import Foundation


class CourseModel: ObservableObject  {
    
    //Optional Values
    var id : Int = 0
    var courseImageURL: String = ""
    var courseTitle: String = ""
    var courseDescription: String = ""
    var courseDuration: String = ""
    var coursesCount: String = ""
    var courseType: String = ""
    
    init() {}
    
    // Getting data from response
    init(response : [String : Any]) {
        
        if let id = response["id"] as? Int {
            self.id = id
        }
        
        if let courseImageURL = response["courseImageURL"] as? String {
            self.courseImageURL = courseImageURL
        }
        
        if let courseTitle = response["courseTitle"] as? String {
            self.courseTitle = courseTitle
        }
        
        if let courseDescription = response["courseDescription"] as? String {
            self.courseDescription = courseDescription
        }
        
        if let courseDuration = response["courseDuration"] as? String {
            self.courseDuration = courseDuration
        }
        
        if let coursesCount = response["coursesCount"] as? String {
            self.coursesCount = coursesCount
        }
        
        if let coursesType = response["courseType"] as? String {
            self.courseType = coursesType
        }
        
    }
    
    
    
}
