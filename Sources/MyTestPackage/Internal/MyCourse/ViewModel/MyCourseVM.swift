//
//  MyCourseVM.swift
//  ABOAcademy
//
//  Created by Shrinivas Reddy on 23/02/22.
//

import Foundation
import Amway_Base_Utility

enum MyCourses: String, CaseIterable {
    
    case requiredCourses = "Required"
    case inProgressCourses = "In Progress"
    case sharedCourses = "Shared"
    case favoriteCourses = "Favorite"
    case downloadedCourses = "Downloaded"
    case completedCourses = "Completed"
}

enum MyCoursesSortByFilter: String, CaseIterable {
    case recentActivity = "Recent Activity"
    case a2z = "A-Z"
    case z2a = "Z-A"
    case new2Old = "Newest to Oldest"
    case old2new = "Oldest to Newest"
}

class MyCourseVM: ObservableObject {
    
    static let shared = MyCourseVM()
    
    @Published var myCourses : [CourseModel] = []
    @Published var filteredCourses : [CourseModel] = []
    @Published var clickedCard: MyCourses = .requiredCourses
    @Published var courseCardType: CourseType = .Default
    
    @Published var coursesEmptyState : [MyCourseEmptyModel] = []

    @Published var selectedCourseEmptyData: MyCourseEmptyModel = MyCourseEmptyModel()

//    var filteredCourseType: CourseType = .Default

    init() {
        myCourses = DashboardViewModel.shared.courses
    }
    

}

extension MyCourseVM {
    
    func getSelectedMyCoursesData(_ myCourseType: MyCourses, isFallThrough: Bool) {
        
        switch myCourseType {
        
            case .requiredCourses:
                filteredCourses = myCourses.filter { $0.courseType == MyCourses.requiredCourses.rawValue }
                courseCardType = .Required
                clickedCard = MyCourses.requiredCourses
                if filteredCourses.isEmpty && isFallThrough {
                    fallthrough
                }
            case .inProgressCourses:
                filteredCourses = myCourses.filter { $0.courseType == MyCourses.inProgressCourses.rawValue }
                courseCardType = .Default
                clickedCard = MyCourses.inProgressCourses

                if filteredCourses.isEmpty && isFallThrough {
                    fallthrough
                }
            case .sharedCourses:
                filteredCourses = myCourses.filter { $0.courseType == MyCourses.sharedCourses.rawValue }
                courseCardType = .Shared
                clickedCard = MyCourses.sharedCourses

                if filteredCourses.isEmpty && isFallThrough {
                    fallthrough
                }
            case .favoriteCourses:
                filteredCourses = myCourses.filter { $0.courseType == MyCourses.favoriteCourses.rawValue }
                courseCardType = .Default
                clickedCard = MyCourses.favoriteCourses

                if filteredCourses.isEmpty && isFallThrough {
                    fallthrough
                }
            case .downloadedCourses:
                filteredCourses = myCourses.filter { $0.courseType == MyCourses.downloadedCourses.rawValue }
                courseCardType = .Default
                clickedCard = MyCourses.downloadedCourses

                if filteredCourses.isEmpty && isFallThrough {
                    fallthrough
                }
            case .completedCourses:
                filteredCourses = myCourses.filter { $0.courseType == MyCourses.completedCourses.rawValue }
                courseCardType = .Default
                clickedCard = MyCourses.completedCourses
                if filteredCourses.isEmpty && isFallThrough {
                    fallthrough
                }
            default:
                filteredCourses = myCourses
        }
    }

    func getSelectedCourseEmptyState() {
        
        for emptyData in coursesEmptyState {
            if emptyData.courseType == clickedCard.rawValue {
                selectedCourseEmptyData = emptyData
            }
        }
    }
    
    //Get Course Empty Data
    func getEmptyCourseData() {
        let tempData = PackageManager.bundle
        if let courseData = tempData.url(forResource: "MyCourseEmptyState", withExtension: "json") {
            do {
                let data = try Data(contentsOf: courseData, options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any]

//            if  let courseData = Amway_Base_Utility.CommonUtils.fetchDataFromLocalJson(name: "CourseData") as? [String: Any] {
                if let courses = jsonResult!["CoursesEmptyState"] as? [[String: Any]] {
                    for item in courses {
                        let courseState = MyCourseEmptyModel(response: item)
                        self.coursesEmptyState.append(courseState)
                    }
                }
            }
            catch {

            }
        }
    }
}
