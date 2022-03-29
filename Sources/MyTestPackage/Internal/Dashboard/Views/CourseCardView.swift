//
//  CourseCardView.swift
//  ABOAcademy
//
//  Created by Shrinivas Reddy on 11/01/22.
//

// This card can be used for Learning Paths, Courses For You, Required Courses

import SwiftUI

enum CourseType: String {
    case Shared = "shared"
    case Required = "required"
//    case Learning = "Learning"
    case Default = "default"
}

struct CourseCardView: View {
    /// Binding value Example
    @Binding var course: CourseModel
    var isNewCourse: Bool = true
    var isAssigned: Bool = true
    var isRequired: Bool = false
    var isLearningPath: Bool = true
    var courseType: CourseType = .Default
    var imageName: String = "Course"
    var isFromMyCoursesView: Bool = false
    var lineLimit: Int = 4
    var cornerRadius: CGFloat = 12
    var isCoursesListView: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .top) {
                Image(imageName, bundle: PackageManager.bundle)
                    .resizable()
                    // .aspectRatio(contentMode: .fit)
                    .frame(height: 160)
                // Uncomment below code once we get the image URL from the API.
                //                    AsyncImage(url: URL(string: ""), content: { image in
                //                            image.resizable()
                //                                 .aspectRatio(contentMode: .fit)
                ////                                 .frame(maxWidth: 300, maxHeight: 100)
                //                        },
                //                        placeholder: {
                //                          ProgressView()
                //                        }
                //                    )
                
                // TODO: If required add scroll view
                HStack(alignment: .top) {
                    HStack(alignment: .top, spacing: 4) {
                        if isNewCourse {
                            // TODO: - Create a cutsom componenet
                            TagView(image: "New")
                        }
                        if courseType == .Shared || courseType == .Required {
                            // TODO: - Create a cutsom componenet
                            
                            TagView(image: courseType == .Shared ? "Shared" : "Required", backgroundColor: courseType == .Shared ? Color.lightGreen : Color.alertLightOrange, forgroundColor: courseType == .Shared ? .darkGreen : .alertOrange)
                        }
                    }
                    .padding([.horizontal, .top], 12)
                    Spacer()
                    
                    if courseType == .Shared {
                        // TODO: create a custom component
                        Button {
                            print("Delete Button pressed")
                        } label: {
                            // TODO: Obsereve the changes
                            Image("CloseBlackIcon", bundle: PackageManager.bundle)
                                .padding(20)
                                .background(Color.white)
                                .frame(width: 24, height: 24)
                                .clipShape(Circle())
                        }
                        .padding([.top, .trailing], 8)
                        .opacity(isFromMyCoursesView ? 0 : 1)
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 0) {
                ///
                /// Course Title
                Text(course.courseTitle)
                    .padding(.top, 12)
                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_medium, fontSize: isCoursesListView ? .regular : .medium))
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(2)
                    .foregroundColor(.amwayBlack)
                
                ///
                /// Course Description
                Text(course.courseDescription)
                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_regular, fontSize: .regular))
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(lineLimit)
                    .foregroundColor(.darkGray)
                    .padding(.top, 8)
                
                ///
                /// Bottom section
                HStack(spacing: 8) {
                    // Label(course.courseDuration, image: "TimeIcon")
                    // .padding(.horizontal)
                    // TODO: Create custom component
                    HStack(spacing: 4) {
                        Image("TimeIcon", bundle: PackageManager.bundle)
                        Text(course.courseDuration)
                    }
                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_medium, fontSize: .regular))
                    .foregroundColor(.darkPurple)
                    
                    // Text("•")
                    
                    //                    if isLearningPath {
                    //
                    //                        HStack(spacing: 4) {
                    //                            Image("CoursesIcon", bundle: .module)
                    //                            Text(course.coursesCount)
                    //                            }
                    //                            .font(.getCustomFontWithSize(fontType: .gt_walsheim_medium, fontSize: .regular))
                    //                            .foregroundColor(.darkPurple)
                    //                    }
                    
                    Spacer()
                    HStack(spacing: 4) {
                        Image("FavIcon", bundle: PackageManager.bundle)
                            .resizable()
                            .frame(width: 24, height: 24)
                        
                        if course.id != 1 {
                            Image("DownloadIcon", bundle: PackageManager.bundle)
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                        
                        if course.id == 1 {
                            Image("CertificateIcon", bundle: PackageManager.bundle)
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                    }
                }
                .padding(.vertical, 16)
            }
            .padding(.horizontal, 16)
        }
        .background(Color.white)
        .cornerRadius(cornerRadius)
    }
}

struct CourseCardView_Previews: PreviewProvider {
    static var previews: some View {
        CourseCardView(course: .constant(CourseModel()))
    }
}
