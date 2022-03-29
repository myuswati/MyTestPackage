//
//  ExploreCourseView.swift
//  ABOAcademy
//
//  Created by Shrinivas Reddy on 08/03/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct ExploreCourseView: View {
    
    @StateObject var DashboardData : DashboardViewModel = DashboardViewModel.shared
    @StateObject var FilterData : ExploreFilterVM = ExploreFilterVM.shared

    @State var showExploreFilterView : Bool = false
    @State var totalHeight = CGFloat.zero       // << variant for ScrollView/List
    @State var isAppliedFilter: Bool = false

    @State var tempSubCatData: [SubCategory] = []

    @Environment(\.presentationMode) var presentation
    

    var body: some View {
        
        ZStack {
            
            VStack(alignment:.leading, spacing: 0) {
                
                CustomNavBar(navBarRightIcon: "NavBarExploreFilterIcon", navBarTitle: "Explore") {
//                    FilterData.exploreFilters.removeAll()
                    FilterData.clearAllFilterState()
                    isAppliedFilter = false
                    presentation.wrappedValue.dismiss()
                    
                } rightBarAction: {
                    //right nav bar button action
                    showExploreFilterView.toggle()
                }
                
                ScrollView {
                    
                    VStack(alignment:.leading, spacing: 0) {
                        
                        ScrollView {
                            
                            //Applied Filter section
                            VStack(alignment: .leading, spacing: 0) {
                                
                                ExploreHeader(headerTitle: "6 Courses", fontSize: .vvLarge, showClearAll: true, clearAllFilter: {
                                    FilterData.clearAllFilterState()
                                    isAppliedFilter = false
                                })
                                .frame(height: 28)
                                .padding(.top, 39)
                                .padding(.bottom, 16)
                                .padding([.leading, .trailing], 16)

                                GeometryReader { geo in
                                    
                                    ScrollView(.vertical) {
                                        
                                        VStack(alignment: .center) {
                                            
                                            ExploreAppliedFilterView(selectedFilters: $FilterData.exploreFilters, totalHeight: $totalHeight, tempSubCatData: $tempSubCatData, isFilterApplied: $isAppliedFilter, geometry: geo)
                                            
                                        }
                                    }
                                }
                                .frame(height: isAppliedFilter ? totalHeight : 0)// << variant for ScrollView/List
                                .padding([.leading, .trailing], 8)
                            }
                            .opacity(isAppliedFilter ? 1 : 0)
                            .if(!isAppliedFilter) { view in
                                view
                                    .frame(height: 0)
                            }

                            //Show below view only if filter are not applied
                            
                            VStack {
                                //Newest Course Section
                                VStack(alignment: .leading,spacing: 0) {
                                    
                                    ExploreHeader(headerTitle: "Newest Courses")
                                        .padding(.top, 32)
                                        .padding([.leading, .bottom], 16)
                                    
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 8) {
                                            
                                            ForEach(0..<DashboardData.courses.count, id:\.self) { index in
                                                CourseCardView(course: $DashboardData.courses[index],courseType: .Default, imageName: "RequiredCourse", lineLimit: 3)
                                                    .frame(width: 284)
                                            }
                                        }
                                        .padding([.leading, .trailing], 16)
                                    }
                                }
                                
                                //Learning Paths Section
                                VStack(alignment: .leading,spacing: 0) {
                                    
                                    ExploreHeader(headerTitle: "Learning Paths")
                                        .padding(.top, 32)
                                        .padding([.leading, .bottom], 16)

                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 8) {
                                            
                                            ForEach(0..<DashboardData.courses.count, id:\.self) { index in
                                                CourseCardView(course: $DashboardData.courses[index],courseType: .Default, imageName: "RequiredCourse", lineLimit: 3)
                                                    .frame(width: 284)
                                            }
                                        }
                                        .padding([.leading, .trailing], 16)
                                    }
                                }
                                
                                //Course Catalog Section
                                VStack(alignment: .leading,spacing: 0) {
                                    
                                    ExploreHeader(headerTitle: "Course Catalog")
                                        .padding(.top, 32)
                                        .padding([.leading, .bottom], 16)

                                    ScrollView(.horizontal, showsIndicators: false) {
                                        VStack(spacing: 16) {
                                            
                                            ForEach(0..<DashboardData.courses.count, id:\.self) { index in
                                                CourseCardView(course: $DashboardData.courses[index],courseType: .Default, imageName: "RequiredCourse", lineLimit: 3)
                                                    .frame(width: UIScreen.main.bounds.width - 32)
                                            }
                                        }
                                        .padding([.leading, .trailing], 16)
                                    }
                                }
                            }
                            .opacity(isAppliedFilter ? 0 : 1)
                            .if(isAppliedFilter) { view in
                                view
                                    .frame(height: 0)
                            }
                            
                            //Show below view only if filters are applied
                            VStack {
                                VStack(spacing: 16) {
                                    
                                    ForEach(0..<DashboardData.courses.count, id:\.self) { index in
                                        CourseCardView(course: $DashboardData.courses[index],courseType: .Default, imageName: "RequiredCourse", lineLimit: 3)
                                            .frame(width: UIScreen.main.bounds.width - 32)
                                    }
                                }
                                .padding([.leading, .trailing], 16)
                            }
                            .if(!isAppliedFilter) { view in
                                view
                                    .frame(height: 0)
                            }
                            .opacity(isAppliedFilter ? 1 : 0)
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .background(Color.exploreBackGround)
            .frame(width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height)
            .onAppear() {
                DashboardData.getCourseData()
                FilterData.getExploreFiltersData()
            }
            
            if showExploreFilterView {
                                
                VStack {
                    
                    Spacer()
                    
                    CustomBottomPopUp(title: "", showContentView: $showExploreFilterView, handleDragGesture: .constant(true), handleBgTapGesture: .constant(false), disableHorizontalPadding: true, showTitle: false, drawerColor: .darkGray, showDrawerInZStack: false, showDrawerBackgroundColor: true) {
                            ExploreFilterView() { appliedFilters in
                                
                                //Applied Filter Clicked
                                isAppliedFilter = true
                                showExploreFilterView = false
                                FilterData.appliedFilterState()
                                
                            } cancelAction: {
                                FilterData.cancelFilterState()
                                showExploreFilterView = false
                            }
                            .frame(height: 530)
                    }
                }
            }
        }
    }
}

struct ExploreHeader: View {
    
    var headerTitle: String = ""
    var fontSize: customFontSize = .medium
    var showClearAll: Bool = false
    var clearAllFilter : (() -> Void)?
    
    var body: some View {
        
        HStack() {
            
            Text(headerTitle)
                .font(.getCustomFontWithSize(fontType: .gt_walsheim_bold, fontSize: fontSize ))
                .foregroundColor(.amwayBlack)
            
            Spacer()
            
            Button {
                
                if let clearAllFilter = clearAllFilter {
                    clearAllFilter()
                }
                
            } label: {
                
                HStack {
                    
                    Text("Clear All")
                        .font(.getCustomFontWithSize(fontType: .gt_walsheim_bold, fontSize: .regular))
                        .foregroundColor(.darkPurple)
                        .padding(.trailing, 8)
                    Image("CloseIcon", bundle: PackageManager.bundle)
                }
            }
            .opacity(showClearAll ? 1 : 0)
        }
    }
}


@available(iOS 15.0, *)
struct ExploreCourseView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreCourseView()
    }
}
