//
//  DashboardView.swift
//  ABOAcademy
//
//  Created by Shrinivas Reddy on 25/01/22.
//

import SwiftUI
import SheeKit

@available(iOS 15.0, *)
struct DashboardView: View {
    
    @StateObject var DashboardData : DashboardViewModel = DashboardViewModel.shared
    @State var showCousreDetails : Bool = false
    @State var selectCourse : CourseModel = CourseModel()
    @State var showCertificateDetails : Bool = false
    @State var showWithoutCertificateDetails : Bool = false
    @State var showCompletionDetails: Bool = false
    @State private var selectedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = UISheetPresentationController.Detent.Identifier.medium
    
    
    var body: some View {
        ZStack {
            VStack(alignment:.leading,spacing: 0) {
                NavigationView {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            //Welcome Video Section
                            if DashboardViewModel.shared.getCardShowStatus(.welcomeVideoCard) {
                                
                                Section() {
                                    WelcomeVideoCardView()
                                    
                                }
                                .listRowBackground(Color.darkPurple)
                                .listSectionSeparator(.hidden)
                                // .frame(height:  gp.size.height * 0.4)
                                
                            }
                            
                            VStack(alignment: .leading, spacing: 32) {
                                
                                
                                //Required Course Card Section
                                if DashboardData.getCardShowStatus(.requiredCoursesCard) {
                                    VStack(alignment: .leading,spacing: 16) {
                                        ListHeader(headerTitle: "Required Courses", isRelatedToCourses: true)
                                            .padding(.trailing, 16)
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(spacing: 8) {
                                                //Binding Example
                                                ForEach(0..<DashboardData.courses.count, id:\.self) { index in
        //                                                NavigationLink(destination:
        //                                                                CertificateCourseCompletion()){
                                                    CourseCardView(course: $DashboardData.courses[index],courseType: .Required, imageName: "RequiredCourse")
                                                        .frame(width: 284)
                                                        .onTapGesture {
                                                            selectCourse = DashboardData.courses[index]
                                                            showCertificateDetails.toggle()
                                                        }
                                                        
                                                        
        //                                                }
        //                                                                .animation(.easeIn)
        //                                                .buttonStyle(PlainButtonStyle())

                                                    
                                                }
                                            }
                                            .shee(isPresented: $showCertificateDetails) {
        //                                            CompletionDetailsView(course:selectCourse)
                                                CertificateCourseCompletion(showCertificateDetails: $showCertificateDetails, showCompletionDetails: $showCompletionDetails)

                                            }
                                        }
                                    }
                                }
                                
                                
                                //Assigned Course Card Section
                                if DashboardViewModel.shared.getCardShowStatus(.assignedCoursesCard) {
                                    VStack(alignment: .leading,spacing: 16) {
                                        ListHeader(headerTitle: "Shared With Me", isRelatedToCourses: true)
                                            .padding(.trailing, 16)
                                        
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(spacing: 8) {
                                                //Binding Example
                                                ForEach(0..<DashboardData.courses.count, id:\.self) { index in
                                                    CourseCardView(course: $DashboardData.courses[index],courseType: .Shared)
                                                        .frame(width: 284)
                                                        .onTapGesture {
                                                            selectCourse = DashboardData.courses[index]
                                                                showWithoutCertificateDetails.toggle()
                                                            }
                                                }
                                            }
                                            
                                            .shee(isPresented: $showWithoutCertificateDetails) {
                                                 WithoutCertCourseCompltetion(showWithoutCertificateDetails: $showWithoutCertificateDetails, showSecondView: $showCompletionDetails)
                                                }
                                        }
                                    }
                                }
                                
                                // Course For You Card Section
                                if DashboardViewModel.shared.getCardShowStatus(.assignedCoursesCard) {
                                    VStack(alignment: .leading,spacing: 16) {
                                        ListHeader(headerTitle: "Courses For You", isRelatedToCourses: true, headerType: .small)
                                            .padding(.trailing, 16)
                                        
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(spacing: 8) {
                                                //Binding Example
                                                ForEach(0..<DashboardData.courses.count, id:\.self) { index in
                                                    
                                                    CourseCardView(course: $DashboardData.courses[index])
                                                        .frame(width: 284)
                                                        .onTapGesture {
                                                        selectCourse = DashboardData.courses[index]
                                                            showCousreDetails.toggle()
                                                        }
                                                }
                                            }
                                            .shee(isPresented: $showCousreDetails) {
                                                 CourseDeatilsMainView(course: selectCourse )
                                                }
                                        }
                                    }
                                }
                                
                                //InProgress Course Card Section
                                if DashboardViewModel.shared.getCardShowStatus(.inProgressCoursesCard) {
                                    VStack(alignment: .leading,spacing: 16) {
                                        ListHeader(headerTitle: "In Progress", isRelatedToCourses: false)
                                           
                                        InProgressCarouselView()
                                    }
                                    .padding(.trailing, 16)
                                    
                                }
                                
                                //Quick Start Courses Section
                                if DashboardViewModel.shared.getCardShowStatus(.quickStartCoursesCard) {
                                    
                                    VStack(alignment: .leading,spacing: 16) {
                                        
                                        ListHeader(headerTitle: "Quick Start Courses", isRelatedToCourses: false,headerType: .small)
                                        
                                        VStack(alignment: .center, spacing: 16) {
                                            
                                            ForEach(0..<getQSCoursesCount(), id:\.self) { index in
                                                QuickStartCardView(course: $DashboardData.courses[index])
                                                if index != getQSCoursesCount() - 1 {
                                                    Divider()
                                                }
                                            }
                                        }
                                        .padding(.all, 16)
                                        .background(Color.white)
                                        .customRoundedRectangle()
                                        
                                    }
                                    .padding(.trailing, 16)
                                    
                                }
                                
                                if DashboardViewModel.shared.getCardShowStatus(.exploreCard) {

                                    NavigationLink(destination: ExploreCourseView()) {
                                                                        SectionView(image: "ExploreCourse", title: "Explore Courses", subtitle: "Browse all the courses  Amway Academy has to offer.", forgroundColor: Color.white, backgroundColor: Color.darkPurple)
                                                                            .padding(.trailing, 16)
                                                                    }
                                                                    .buttonStyle(PlainButtonStyle())
                                }
                                
                              
                                
                                //Learning Path Card Section
                                if DashboardViewModel.shared.getCardShowStatus(.learningPathCard) {
                                    
                                    VStack(alignment: .leading,spacing: 16) {
                                        
                                        ListHeader(headerTitle: "Learning Paths", isRelatedToCourses: true, headerType: .small)
                                            .padding(.trailing, 16)
                                        
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(spacing: 16) {
                                              
                                                //Binding Example
                                                ForEach(0..<DashboardData.courses.count, id:\.self) { index in
                                            NavigationLink(destination: LearningPathDetails(course:DashboardData.courses[index] )) {
                                                    CourseCardView(course: $DashboardData.courses[index], imageName: "LearningPath")
                                                        .frame(width: 284)
                                                }
                                                .buttonStyle(PlainButtonStyle())
                                                    
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                if DashboardViewModel.shared.getCardShowStatus(.myCourses) {

                                        NavigationLink(destination: MyCourseView()) {
                                            SectionView(image: "Courses", title: "My Courses", subtitle: "View all your Required, Assigned, In Progess, Favorite, Downloaded, and completed courses. ", forgroundColor: Color.darkPurple, backgroundColor: Color.white)
                                                .padding(.trailing, 16)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                }
                                
        //                            SectionView(image: "MyCourses", title: "My Courses", subtitle: "View all your Required, Assigned, In Progess, Favorite, Downloaded, and completed courses.", forgroundColor: Color.darkPurple, backgroundColor: Color.white)
                                
                                /*
                                 //Courses For You Section For Hero Content
                                 Section(header: HStack {
                                 ListHeader(headerTitle: "Courses For You", isRelatedToCourses: true)
                                 .padding()
                                 Spacer()
                                 }
                                 .background(Color.darkPurple)
                                 .listRowInsets(EdgeInsets(top: -10, leading: 0, bottom: -10, trailing: 0))
                                 ) {
                                 ScrollView(.horizontal, showsIndicators: false) {
                                 LazyHStack(spacing: 0, pinnedViews: .sectionHeaders) {
                                 CourseCardView()
                                 .frame(width: gp.size.width * 0.80)
                                 CourseCardView()
                                 .frame(width: gp.size.width * 0.80)
                                 CourseCardView()
                                 .frame(width: gp.size.width * 0.80)
                                 CourseCardView()
                                 .frame(width: gp.size.width * 0.80)
                                 .padding(.trailing)
                                 }
                                 }
                                 }
                                 .background(Color.darkPurple)
                                 .listRowBackground(Color.darkPurple)//Only if first row
                                 .listSectionSeparator(.hidden)
                                 .padding(EdgeInsets(top: 10, leading: -20, bottom: 10, trailing: -20))
                                 */
                            }
                            .padding(.leading, 16)
                            .padding(.vertical, 32)
                            
                        .shee(isPresented: $showCompletionDetails) {
                            CompletionDetailsView(course:selectCourse)

                        }
                            
                            
                            
                        }
                        .navigationBarTitleDisplayMode(.inline)
                        .onAppear {
                            DashboardData.getCourseData()
                        }
                    }
                    .background(Color.backGround)
                }
            }
            .background(Color.backGround)
            .frame(width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height)
        
        
            
            if (showCousreDetails || showCertificateDetails || showWithoutCertificateDetails || showCompletionDetails) {
                Color.white.opacity(0.5)
                    .ignoresSafeArea()
                    .transition(.move(edge: .bottom))
                    .animation(.default)
                
            }
            
        }
    }
    
    func getQSCoursesCount() -> Int {
        var quickStartCoursesCount = $DashboardData.courses.count
        if $DashboardData.courses.count > 3 {
            quickStartCoursesCount = 3
        }
        return quickStartCoursesCount
    }
}

struct ListHeader: View {
    
    var headerTitle: String = ""
    var isRelatedToCourses: Bool = false
    var headerType : HeaderType = .Large
    
    var viewAllAction : (() -> Void)?
    var courseType: CourseType = .Default
    
    var body: some View {
        HStack() {
            Text(headerTitle)
                .font(.getCustomFontWithSize(fontType: .gt_walsheim_bold, fontSize: headerType == .Large ? .vvLarge : .medium ))
                .foregroundColor(.amwayBlack)
                
            Spacer()
            
            Button {
                if let viewAllAction = viewAllAction {
                    viewAllAction()
                }
            } label: {
                
                NavigationLink(destination: CoursesListView(courseType: courseType)) {
                    VStack(alignment:.leading, spacing : 4) {
                        
                    Text("View All")
                        .font(.gtWalsheimBoldWithSizeBold14)
                        .foregroundColor(.darkPurple)
                        
                    Rectangle()
                        .frame(width: 52,height: 2)
                        .foregroundColor(.darkPurple)
                    }
                }
                
            }
        }
        //Apply below padding only for Courses For You, Learning Paths, Required Courses
        //  .padding(isRelatedToCourses ? [.leading, .trailing] : [])
    }
}

@available(iOS 15.0, *)
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DashboardView()
        }
    }
}

enum HeaderType : String {
    case Large = "large"
    case small = "small"
}
