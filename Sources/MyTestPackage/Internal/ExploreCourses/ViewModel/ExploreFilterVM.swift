//
//  ExploreFilterVM.swift
//  ABOAcademy
//
//  Created by Shrinivas Reddy on 11/03/22.
//

import Foundation
import Amway_Base_Utility

class ExploreFilterVM: ObservableObject {
    
    static let shared = ExploreFilterVM()
    
    @Published var exploreFilters : [ExploreFilterModel] = []
    @Published var originalFilters : [ExploreFilterModel] = []
    @Published var selectedStateExploreFilters : [ExploreFilterModel] = []
    @Published var selectedCategoryIndex: Int = 0
    @Published var selectedFilter : [SubCategory] = []
    @Published var selectedCategoryFilter : String = ""
    
}

extension ExploreFilterVM {
    
    //Get Explore Filters Data
    func getExploreFiltersData() {
        let tempData = PackageManager.bundle
        if let courseData = tempData.url(forResource: "ExploreFilter", withExtension: "json") {
            do {
                let data = try Data(contentsOf: courseData, options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any]

//            if  let courseData = Amway_Base_Utility.CommonUtils.fetchDataFromLocalJson(name: "CourseData") as? [String: Any] {
                if let filters = jsonResult!["filters"] as? [[String: Any]] {
                    for item in filters {
                        let exploreFilter = ExploreFilterModel(response: item)
                        self.exploreFilters.append(exploreFilter)
                        self.originalFilters.append(exploreFilter)
                        self.selectedStateExploreFilters.append(exploreFilter)
                    }
                }
            }
            catch {

            }
        }
    }
    
    func appliedFilterState() {
        self.selectedStateExploreFilters = self.exploreFilters
    }
    
    func cancelFilterState() {
        self.exploreFilters = self.selectedStateExploreFilters
    }
    
    func clearAllFilterState() {
        self.exploreFilters = self.originalFilters
        self.selectedStateExploreFilters = self.exploreFilters
    }
    
    func getAllSubCatSelected() -> [SubCategory] {
        var tempSubCatArray: [SubCategory] = []

        for cat in selectedStateExploreFilters {
            for subCat in cat.subCategory {
                if subCat.isMarked == true {
                    tempSubCatArray.append(subCat)
                }
            }
        }
        return tempSubCatArray
    }
    
    func removeSelectedFilter(subCategory: SubCategory) {
        for i in 0..<self.exploreFilters.count {
            for j in 0..<self.exploreFilters[i].subCategory.count {
                if self.exploreFilters[i].subCategory[j] == subCategory {
                    self.exploreFilters[i].subCategory[j].isMarked = false
                }
            }
        }
        self.appliedFilterState()
    }
    
    func setSelectedCategoryIndex(index: Int) {
        selectedCategoryIndex = index
    }
    
//    //Get subcategory filter for selected category filter
//    func getSubcategoryFilter(categoryFilter: String) -> [SubCategory] {
//        for item in exploreFilters {
//            if item.category == categoryFilter {
//                return item.subCategory
//            }
//        }
//        return []
//    }
    
    func saveSelectedCategory(categoryFilter: String) {
        self.selectedCategoryFilter = categoryFilter
    }
    
    /*
    func updateSelectedFilter(categoryFilter: [SubCategory]) {
        for index in 0..<categoryFilter.count {
            if (self.selectedFilter.contains(categoryFilter[index]) && !categoryFilter[index].isMarked) {
                self.selectedFilter = self.selectedFilter.filter() {$0.id != categoryFilter[index].id}
            } else {
                self.selectedFilter.append(categoryFilter[index])
            }
        }
    }*/
}
