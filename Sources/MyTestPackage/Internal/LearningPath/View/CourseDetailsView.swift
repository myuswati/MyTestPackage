//
//  CourseDetailsView.swift
//  ABOAcademy
//
//  Created by Swapnil Tilkari on 23/02/22.
//

import SwiftUI

struct CourseDetailsView: View {
    @Binding var showLangView : Bool
    @Binding var selectedLang : String
    
    @State var progressValue: Float = 0.1
    var course : CourseModel = CourseModel()
    var isLearning : Bool = false
    var courseCompleteion : Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            
            ZStack(alignment:.topLeading) {
                
                
                Image("LearningPathDetails", bundle: PackageManager.bundle)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: 212)
                if !courseCompleteion {
                HStack {
                TagView(image: "New")
                  Spacer()
                }
                .padding(16)
                }
                
            }
            
            VStack(alignment: .leading, spacing: 16) {
                
                HStack {
                    CustomLabelWithImageType2(image: "DownArrow", title: selectedLang )
                        .onTapGesture {
                            showLangView.toggle()
                        }
                    Spacer()
                    CustomLabelWithImageType2(image: "Share", title: "Share" )
                    
                }
              
                if courseCompleteion {
                    
                    VStack(alignment: .leading, spacing: 4) {
                        ///
                        /// Course Title
                        Text("Course Completed!")
                            .font(.getCustomFontWithSize(fontType: .gt_walsheim_bold, fontSize: .xxxLarge))
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(2)
                            .foregroundColor(.darkPurple)
                        HStack {
//                            Text("")
//                                .font(.getCustomFontWithSize(fontType: .gt_walsheim_regular, fontSize: .xxxLarge))
                                
                            HStack {
                                Text("Active Listening")
                                    .italic()
                                    .font(.gtWalsheimBoldWithSizeBold14)
                                    .foregroundColor(Color.darkGray)
                                Text("was completed on 01/25/2022.")
                                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_regular, fontSize: .regular))
                                    .foregroundColor(Color.darkGray)
                            }
                            Spacer()
                        }
                      
                    }
                }else{
                    if !isLearning {
                    HStack(alignment: .center) {
                        
                        Label("\(course.courseDuration) left", image: "LoadIcon")
                            .font(.gtWalsheimMediumWithSizeMedium14)
                            .foregroundColor(.darkPurple)
                          
                        
                        ProgressBar(value: $progressValue)
                            .frame(height: 10)
                           
                        Spacer()
                    }
                    }
                HStack(spacing: 8) {
                    
                    CustomLabelWithImage(image: "TimeIcon", title: "9m")
                    
                    Text("•")
                    
                    CustomLabelWithImage(image: "CoursesIcon", title: "10 Courses")
                    
                    Spacer()
                }
                
                    CourseDescriptionView(course: course)
                }
                
                HStack(spacing: 4) {
                    Image("FavIconBlackEmpty", bundle: PackageManager.bundle)
                        .resizable()
                        .frame(width: 40, height: 40)

                    
                    Image("DownloadIConBlackEmpty", bundle: PackageManager.bundle)
                        .resizable()
                        .frame(width: 40, height: 40)
                       
                        
                    Spacer()
                }
                
            }
            .padding(16)
        
             Spacer()
            
        }
    }
}

struct CourseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetailsView(showLangView: .constant(false), selectedLang: .constant("English"))
    }
}

struct CourseDescriptionView: View {
    var course : CourseModel = CourseModel()
    var courseCompleteion : Bool = false
    @State var showSection : Bool = true
    
    var body: some View {
       
        VStack(alignment: .leading, spacing: 0){
            VStack(alignment: .leading, spacing: 8) {
                if courseCompleteion {
                HStack{
                    Text("Course Description")
                        .font(.getCustomFontWithSize(fontType: .gt_walsheim_bold, fontSize: .medium))
                    Spacer()
                   
                        Image("Chevron", bundle: PackageManager.bundle)
                            .rotationEffect(showSection ? .degrees(180): .degrees(0))
                            .onTapGesture {
                                showSection.toggle()
                            }
                    }
                   // .padding(16)
                    }
                   
            if showSection {
            
            VStack(alignment: .leading, spacing: 4) {
                
                if courseCompleteion {
                CustomLabelWithImage(image: "TimeIcon", title: "9m")
                }
                
                ///
                /// Course Title
                
                Text(course.courseTitle)
                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_medium, fontSize: .vlargemid))
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(2)
                    .foregroundColor(.amwayBlack)
                
                Text("Taught by:Ryan Albertsun")
                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_medium, fontSize: .medium))
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(2)
                    .foregroundColor(.amwayBlack)
                
                ///
                /// Course Description
                Text(course.courseDescription)
                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_regular, fontSize: .regular))
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(4)
                    .foregroundColor(.gray)
            }
            .padding(.top, 8)
            
            VStack(spacing: 16) {
                ScrollView(.horizontal, showsIndicators: false ) {
                    HStack {
                        ForEach(0..<4){ i in
                            CustomLabelWithImage(image: "CoursesIcon", title: "Selling Nutrilite Products", backgroundColor: Color.lightPurple)
                        }
                    }
                }
                
                
                
            }
                }
            }
           
        }
        
    }
}
