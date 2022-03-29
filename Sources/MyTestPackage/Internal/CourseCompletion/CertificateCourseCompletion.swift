//
//  CertificateCourseCompletion.swift
//  ABOAcademy
//
//  Created by Swapnil Tilkari on 07/03/22.
//

import SwiftUI

struct CertificateCourseCompletion: View {
    @Binding var showCertificateDetails: Bool
    @Binding var showCompletionDetails: Bool
    @State var showCertificate : Bool = false
    var body: some View {
        ZStack {
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
                        Image("CertificateLarge", bundle: PackageManager.bundle)
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width,height: 300)
                        
                        
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
                            
                            Button {
                                showCertificate.toggle()
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("View Certificate")
                                        .padding(9)
                                        .foregroundColor(Color.darkPurple)
                                        .font(.getCustomFontWithSize(fontType: .gt_walsheim_bold, fontSize: .regular))
                                    Spacer()
                                    
                                }
                                .background(Color.white)
                                .customRoundedRectangle(cornerRadius: 24)
                                .padding(.top,24)
                            }
                            
                        }
                        .padding(16)
                        .padding(.bottom, 80)
                        .foregroundColor(Color.white)
                        // .frame(width: UIScreen.main.bounds.width)
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
                        showCompletionDetails = true
                        showCertificateDetails = false
                    }
            }
            
            if showCertificate {
                VStack {
                    Spacer()
                    CustomBottomPopUp(title: "",showContentView:$showCertificate,handleDragGesture: .constant(true),handleBgTapGesture:.constant(true), showTitle :  false,drawerColor: .white) {
                        
                        CertificateBottomPopUp(showCertificate: $showCertificate)
                        //.padding(.top, 30)
                        
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}

struct curvedSideRectangle : Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY) )
        //path.addLine(to: CGPoint(x: 0, y: rect.minY))
        // path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x:0, y: rect.maxY), control: CGPoint(x: rect.midX, y: rect.maxY + 50))
        
        return path
    }
    
    
}

struct CertificateCourseCompletion_Previews: PreviewProvider {
    static var previews: some View {
        CertificateCourseCompletion(showCertificateDetails: .constant(true), showCompletionDetails: .constant(false))
    }
}
