//
//  MyCoursesEmptyView.swift
//  ABOAcademy
//
//  Created by Shrinivas Reddy on 01/03/22.
//

import SwiftUI

struct MyCoursesEmptyView: View {
    
    @Binding var emptyData : MyCourseEmptyModel
    var courseType : MyCourses

    var body: some View {
        
        VStack(spacing: 0) {
            
            Image(emptyData.courseImageURL, bundle: PackageManager.bundle)
                .frame(width: 81, height: 78)
            
            Text(emptyData.courseTitle)
                .padding([.top, .leading, .trailing])
                .padding(.bottom, 8)
                .font(.getCustomFontWithSize(fontType: .gt_walsheim_medium, fontSize: .vLarge))
                .foregroundColor(.amwayBlack)
            
            Text(emptyData.courseDescription)
                .font(.getCustomFontWithSize(fontType: .gt_walsheim_regular, fontSize: .regular))
                .lineLimit(4)
                .foregroundColor(.amwayBlack)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 32)
            
            Button {
                
            } label: {
                
                HStack {
                    Text(emptyData.coursesButtonTitle)
                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_bold, fontSize: .regular))
                    .foregroundColor(.amwayBlack)
                    Image("RightArrowIcon", bundle: PackageManager.bundle)
                }
                .padding([.top], 24)
            }
            .opacity(courseType == .requiredCourses ? 0 : 1)
            Spacer()
        }
    }
}

struct MyCoursesEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        MyCoursesEmptyView(emptyData: .constant(MyCourseEmptyModel()), courseType: .requiredCourses)
    }
}
