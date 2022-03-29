//
//  CoursesListView.swift
//  ABOAcademy
//
//  Created by Shrinivas Reddy on 08/03/22.
//

import SwiftUI

struct CoursesListView: View {
    
    @StateObject var DashboardData : DashboardViewModel = DashboardViewModel.shared
    
    @State var showFilterView : Bool = false
    @State var showEmptyView : Bool = false

    var courseType: CourseType = .Default
    
    @EnvironmentObject var coursesData: DashboardViewModel
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        ZStack {
            
            VStack(alignment:.center, spacing: 0) {
                
                CustomNavBar(navBarRightIcon: "NavBarExploreFilterIcon", navBarTitle: "All Courses For You") {
                    presentation.wrappedValue.dismiss()
                } rightBarAction: {
                    showFilterView.toggle()
                }
                    
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        
                        ForEach(0..<DashboardData.courses.count, id:\.self) { index in
                            CourseCardView(course: $DashboardData.courses[index],courseType: courseType, imageName: "RequiredCourse", lineLimit: 2, cornerRadius: 6, isCoursesListView: true)
                                .frame(width: UIScreen.main.bounds.width - 32)
                        }
                    }
                    .padding([.leading, .trailing], 16)
                }
                .padding([.top, .bottom], 24)
                
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .background(Color.backGround)
            .frame(width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height)
            
            .onAppear() {
                DashboardData.getCourseData()
            }
            
            
            if showFilterView {
                
                VStack {
                    
                    Spacer()
                    
                    
                    CustomBottomPopUp(title: "Sort by", showContentView: $showFilterView, handleDragGesture: .constant(true), handleBgTapGesture: .constant(true), disableHorizontalPadding: true, drawerColor: .darkGray, showDrawerInZStack: false, showDrawerBackgroundColor: true) {

                        VStack(alignment: .leading, spacing: 25) {
                            ScrollView {
                                RadioButtonGroup(items: MyCoursesSortByFilter.allCases.map { $0.rawValue }, selectedId: MyCoursesSortByFilter.allCases[0].rawValue) { selected in
                                    print("Selected is: \(selected)")
                                }
                                .padding(.leading, 16)
                            }
                        }
                        .frame(height: 300)
                    }
                }
            }
        }
    }
}

struct CoursesListView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesListView()
    }
}
