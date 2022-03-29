//
//  RequiredCoursesAlertCardView.swift
//  ABOAcademy
//
//  Created by Shrinivas Reddy on 20/01/22.
//

import SwiftUI

struct RequiredCoursesAlertCardView: View {
    
    var requireCourseAlertTitle: String = "New Required Courses"
    var requireCourseAlertDescription: String = "Congratulations on hitting Platinum! You have 11 new required courses to help you level up again!"
    
    var body: some View {
        HStack {
            VStack {
                Image("BulbIcon", bundle: PackageManager.bundle)
                    .frame(width: 40, height: 40)
                    .offset(y: 0)
                Spacer()
            }
            
            //
            // TODO: Realign Element
            VStack {
                Spacer()
                    .frame(height: 4)
                HStack {
                    Text(requireCourseAlertTitle)
                        .font(.gtWalsheimBoldWithSizeBold14)
                        .foregroundColor(.darkPurple)
                    Spacer()
                    Button {
                        print("Close Button Clicked")
                    } label: {
                        Image("CloseIcon", bundle: PackageManager.bundle)
                            .renderingMode(.original)
                    }
                    .padding([.trailing])
                }
                HStack {
                    Text(requireCourseAlertDescription)
                        .font(.getCustomFontWithSize(fontType: .gt_walsheim_bold, fontSize: .regular))
                        .foregroundColor(.darkPurple)
                        .lineLimit(3)
                        .padding([.trailing])
                    Spacer()
                }
                .padding([.trailing])
                Spacer()
            }
        }
    }
}

struct RequiredCoursesAlertCardView_Previews: PreviewProvider {
    static var previews: some View {
        RequiredCoursesAlertCardView()
    }
}
