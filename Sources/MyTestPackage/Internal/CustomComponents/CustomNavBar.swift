//
//  CustomNavBar.swift
//  ABOAcademy
//
//  Created by Shrinivas Reddy on 23/02/22.
//

import SwiftUI

struct CustomNavBar: View {
    
    var navBarBackIcon: String = "NavBarBackIcon"
    var navBarRightIcon: String = "NavBarMyCourseFilterIcon"
    var navBarTitle: String = "My Courses"
    var navBarHeight: Double = 84.0
    var showRightNavButton: Bool = true
    var leftBarAction : (() -> Void)?

    var rightBarAction : (() -> Void)?
    
    var body: some View {
        
        VStack {
            Spacer()
            HStack(alignment: .bottom) {
                Button {
                    if let leftBarAction = leftBarAction {
                       leftBarAction()
                    }
                } label: {
                    Image(navBarBackIcon, bundle: PackageManager.bundle)
                        .frame(width: 16, height: 18)
                }
                Spacer()
                Text(navBarTitle)
                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_medium, fontSize: .large))
                    .foregroundColor(Color.white)
                Spacer()
                Button {
                    if let rightBarAction = rightBarAction {
                       rightBarAction()
                    }
                } label: {
                    Image(navBarRightIcon, bundle: PackageManager.bundle)
                        .frame(width: 18, height: 20)
                }
                .opacity(showRightNavButton ? 1 : 0)
            }
            .padding([.leading, .trailing], 18)
            .padding(.bottom, 12)
        }
        .frame(height: navBarHeight)
        .background(Color.darkPurple)
    }
}

struct CustomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBar()
    }
}
