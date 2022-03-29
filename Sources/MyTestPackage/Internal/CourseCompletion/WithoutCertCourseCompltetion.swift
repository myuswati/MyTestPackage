//
//  WithoutCertCourseCompltetion.swift
//  ABOAcademy
//
//  Created by Swapnil Tilkari on 09/03/22.
//

import SwiftUI

struct WithoutCertCourseCompltetion: View {
    @Binding var showWithoutCertificateDetails: Bool
    @Binding var showSecondView: Bool
    
    var body: some View {
        ZStack(alignment:.topTrailing) {
        ZStack(alignment:.top) {
        // Image("CertificateConfetti", bundle: .module)
               //.resizable()
            VStack {
                
            }
                .frame(width: UIScreen.main.bounds.width,height: 200)
                .padding(.top, 50)
           
        VStack(alignment:.leading,spacing: 0) {
            Spacer()
            Image("WithoutCertificate", bundle: PackageManager.bundle)
                .resizable()
                .frame(width: UIScreen.main.bounds.width,height: 400)
               
                
        VStack(alignment:.leading,spacing: 0) {
            HStack {
            Text("Active Listening")
                .font(.getCustomFontWithSize(fontType: .gt_walsheim_bold, fontSize: .regular))
                Spacer()
            }
            HStack {
            Text("Well done!\nYou’ve completed\nthis course!")
                .font(.getCustomFontWithSize(fontType: .gt_walsheim_bold, fontSize: .xxxLarge))
                Spacer()
            }
            
//            Button {
//
//            } label: {
//                HStack {
//                    Spacer()
//                Text("View Certificate")
//                    .padding(9)
//                    .foregroundColor(Color.black)
//                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_regular, fontSize: .regular))
//                    Spacer()
//
//                }
//                .background(Color.white)
//                .customRoundedRectangle()
//                .padding(.top,24)
//            }

         }
        //.frame(width: UIScreen.main.bounds.width)
        .padding(16)
        .padding(.bottom, 80)
        .foregroundColor(Color.white)
        
        .background(Color.darkPurple)
        // .clipShape(curvedSideRectangle())
                
            }
          //.frame(height: 450)
        
        
        }
        //
        //.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .navigationBarHidden(true)
            
          Image("CloseBlackIcon", bundle: PackageManager.bundle)
                .padding(16)
                .onTapGesture {
                    showSecondView = true
                    showWithoutCertificateDetails = false
                }
        }
    }
}

struct WithoutCertCourseCompltetion_Previews: PreviewProvider {
    static var previews: some View {
        WithoutCertCourseCompltetion(showWithoutCertificateDetails: .constant(true), showSecondView: .constant(false))
    }
}
