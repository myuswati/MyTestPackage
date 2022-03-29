//
//  MyCourseView.swift
//  ABOAcademy
//
//  Created by Shrinivas Reddy on 22/02/22.
//

import SwiftUI

struct MyCourseView: View {
        
    @StateObject var DashboardData : DashboardViewModel = DashboardViewModel.shared
    @StateObject var myCourseVM : MyCourseVM = MyCourseVM.shared
    
    @State var showFilterView : Bool = false
    @State var showEmptyView : Bool = false

    @EnvironmentObject var coursesData: DashboardViewModel
    
    @Environment(\.presentationMode) var presentation

    var body: some View {
        
        ZStack {
            
            VStack(alignment:.center, spacing: 0) {
                
                CustomNavBar {
                    showEmptyView = false
                    myCourseVM.clickedCard = .requiredCourses
                    presentation.wrappedValue.dismiss()
                } rightBarAction: {
                    //right nav bar button action
                    showFilterView.toggle()
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 8) {

                        ForEach(0..<MyCourses.allCases.count, id:\.self) { index in
                            
                            Button(action: {
                                showEmptyView = true
                                myCourseVM.clickedCard = MyCourses.allCases[index]
                                myCourseVM.getSelectedCourseEmptyState()
                                myCourseVM.getSelectedMyCoursesData(MyCourses.allCases[index], isFallThrough: false)
                            }, label: {
                                Text(MyCourses.allCases[index].rawValue)
                                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_medium, fontSize: .regular))
                                    .foregroundColor(getForegroundColor(index))
                            })
                            .fixedSize()
                            .frame(height: 24)
                            .padding(.horizontal, 10)
                            .background(self.getBackgroundColor(index))
                            .clipShape(Capsule())
                            .customRoundedRectangleOverlay(cornerRadius: 50, color: .darkPurple, lineWidth: 1.0)
                        }
                    }
                    .padding([.leading, .trailing], 16)
                }
                .padding([.top, .bottom], 24)
                
                
                if showEmptyView && myCourseVM.filteredCourses.count == 0 {
                    MyCoursesEmptyView(emptyData: $myCourseVM.selectedCourseEmptyData, courseType: myCourseVM.clickedCard)
                        .padding([.top], 18)
                } else {
                    ScrollView(.vertical, showsIndicators: false) {

                        VStack(alignment: .leading, spacing: 16) {

                            ForEach(0..<myCourseVM.filteredCourses.count, id:\.self) { index in
                                    CourseCardView(course: $myCourseVM.filteredCourses[index], courseType: myCourseVM.courseCardType, isFromMyCoursesView: true)
                                    .padding([.leading, .trailing], 16)
                                    .shadow(radius: 2)
                                    
                            }
                        }
                    }
                }
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .background(Color.backGround)
            .frame(width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height)
            
            .onAppear() {
                myCourseVM.getSelectedMyCoursesData(.requiredCourses, isFallThrough: true)
                myCourseVM.getEmptyCourseData()
            }
            
            
            if showFilterView {
                
                VStack {
                    
                    Spacer()
                    CustomBottomPopUp(title: "Sort by", showContentView: $showFilterView, handleDragGesture: .constant(true), handleBgTapGesture: .constant(true), backgroundColor: .white) {
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
    
    func getBackgroundColor(_ value: Int) -> Color {
        return myCourseVM.clickedCard == MyCourses.allCases[value] ? .darkPurple : .white
    }
    
    func getForegroundColor(_ value: Int) -> Color {
        return myCourseVM.clickedCard == MyCourses.allCases[value] ? .white : .darkPurple
    }

}


struct MyCourseView_Previews: PreviewProvider {
    static var previews: some View {
        MyCourseView()
    }
}
