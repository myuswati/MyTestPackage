//
//  QuickStartCardView.swift
//  ABOAcademy
//
//  Created by Shrinivas Reddy on 12/01/22.
//


//This card can be used for Quick Start Courses(on Dashboard)

import SwiftUI

struct QuickStartCardView: View {
    
    @Binding var course : CourseModel
    var isNew: Bool = false
    var newText: String = "New!"
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 10.0) {
            
            VStack {
                
                ZStack(alignment: .topLeading) {
                    
                    Image("image", bundle: PackageManager.bundle)
                        .resizable()
                        .cornerRadius(AppConstants.dashboardMaxCardCornerRadius)
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 96, height: 96)
                    
                   // VStack(alignment: .leading) {
                        
                        Text("New")
                            .padding([.leading, .trailing], 8)
                            .padding([.top, .bottom], 3)
                            .foregroundColor(.darkPurple)
                            .background(Color.lightPurple)
                            .cornerRadius(4)
                            .font(.getCustomFontWithSize(fontType: .gt_walsheim_medium, fontSize: .regular))
                            .padding([.top, .leading], 8)
                        
//                        Spacer()
//                    }
                   
                }
            }
            
            
            VStack(alignment: .leading,spacing: 4) {
                
                Text(course.courseTitle)
                    .lineLimit(2)
                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_medium, fontSize: .regular))
                    .foregroundColor(.amwayBlack)

                
                Text(course.courseDescription)
                    .lineLimit(2)
                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_medium, fontSize: .regular))
                    .foregroundColor(.darkGray)
                
                Spacer()
                
                HStack {
                    
                Label(course.courseDuration, image: "TimeIcon")
                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_medium, fontSize: .regular))
                    .foregroundColor(.darkPurple)
                    Spacer()
                    
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
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(16)
    }
}

struct QuickStartCardView_Previews: PreviewProvider {
    static var previews: some View {
        QuickStartCardView(course: .constant(CourseModel()))
    }
}
