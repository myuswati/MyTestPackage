//
//  DashboardViewModel.swift
//  ABOAcademy
//
//  Created by Shrinivas Reddy on 01/02/22.
//

import Foundation
import Amway_Base_Utility

enum DashboardCard {
    
    case welcomeVideoCard
    case requiredCoursesCard
    case assignedCoursesCard
    case inProgressCoursesCard
    case coursesForYouCard
    case exploreCard
    case quickStartCoursesCard
    case learningPathCard
    case myCourses
}

class DashboardViewModel: ObservableObject {
    static let shared = DashboardViewModel()
    
    @Published var courses : [CourseModel] = []
}

extension DashboardViewModel {
    
    func getCardShowStatus(_ forCard: DashboardCard) -> Bool {
        switch forCard {
        case .welcomeVideoCard:
            //            return rbacDetails.featuredStories == "2" ? true : false
            return true
        case .requiredCoursesCard:
            return true
        case .assignedCoursesCard:
            return true
        case .inProgressCoursesCard:
            return true
        case .coursesForYouCard:
            return true
        case .exploreCard:
            return true
        case .quickStartCoursesCard:
            return true
        case .learningPathCard:
            return true
        case .myCourses:
            return true
        }
    }
    
    
    
    //Get Course Data
    func getCourseData() {
        let tempData = PackageManager.bundle
        if let courseData = tempData.url(forResource: "CourseData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: courseData, options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any]

//            if  let courseData = Amway_Base_Utility.CommonUtils.fetchDataFromLocalJson(name: "CourseData") as? [String: Any] {
                if let courses = jsonResult!["MyCourses"] as? [[String: Any]] {
                    for item in courses {
                        let course = CourseModel(response: item)
                        self.courses.append(course)
                    }
                }
            }
            catch {

            }
        }
    }
}
