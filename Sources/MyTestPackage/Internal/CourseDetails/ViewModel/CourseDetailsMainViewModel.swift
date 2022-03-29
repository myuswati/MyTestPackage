//
//  COurseDetailsMainViewModel.swift
//  ABOAcademy
//
//  Created by Swapnil Tilkari on 03/03/22.
//

import Foundation
import Amway_Base_Utility

class CourseDetailsMainViewModel : ObservableObject {
  
    @Published var syllabus : [SyllabusModel] = []
    
    static let shared = CourseDetailsMainViewModel()
    
   private init() {
       getSyllabusData()
    }
    
    //Get Course Data
    func getSyllabusData() {
        
        let tempData = PackageManager.bundle
        if let courseData = tempData.url(forResource: "SyllabusData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: courseData, options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any]

//            if  let courseData = Amway_Base_Utility.CommonUtils.fetchDataFromLocalJson(name: "CourseData") as? [String: Any] {
                if let syllabusData = jsonResult!["syllabus"] as? [[String: Any]] {
                    for item in syllabusData {
                        let course = SyllabusModel(response: item)
                        self.syllabus.append(course)
                    }
                }
            }
            catch {

            }
        }
    }
}
