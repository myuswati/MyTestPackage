//
//  CompletionDetailsView.swift
//  ABOAcademy
//
//  Created by Swapnil Tilkari on 09/03/22.
//

import SwiftUI
import SheeKit

@available(iOS 15, *)
@available(iOS 15.0, *)
@available(iOS 15.0, *)
struct CompletionDetailsView: View {
    var course : CourseModel = CourseModel()
    @StateObject var langData = LangViewModel.shared
    @StateObject var syllabusData = CourseDetailsMainViewModel.shared
    @State var showCertificate : Bool = false
    @State private var selectedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = UISheetPresentationController.Detent.Identifier.medium
    
    var body: some View {
        ZStack {
            ZStack(alignment:.top) {
            VStack(alignment: .leading, spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                        CourseDetailsView(showLangView: $langData.showLangView, selectedLang: $langData.selectedLang, course:course,courseCompleteion: true)
                        
                       
                            Text("Your Next Course")
                                .font(.getCustomFontWithSize(fontType: .gt_walsheim_bold, fontSize: .regular))
                                .padding(.horizontal,16)
                                
                            QuickStartCardView(course:.constant(course) )
                                .background(Color.white)
                                .customRoundedRectangle()
                                .customShadow(frontColor: .amwayBlack.opacity(0.1), BackColor: .white)
                                .padding(.horizontal,16)
                                .padding(.bottom, 60)
                                
                        }
                        // .padding(35)
                        .background(
                            GeometryReader { val in
                                VStack {
                                    Spacer()
                                Image("CourseConfetti", bundle: PackageManager.bundle)
                                    .resizable()
                                    .scaledToFit()
                                    //.frame(height: 300)
                                }
                                .offset(y: 10)
                            }
                        )
                   // .padding(16)
                    
                CourseDescriptionView(course: course, courseCompleteion: true, showSection: false)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                       
                    AchivementView(courseCompleteion: true,showSection: false)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                    
                    SyllabusView(courseData: syllabusData,showSection: false, courseCompleteion: true)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                        
                        VStack {
                            
                        }
                        .frame(height: 300)
                        Spacer()
                    
                    }
                    
                    
                    //.frame( height: UIScreen.main.bounds.height + 150)
                }
                
                
               
                
                

                
            }
            .navigationBarHidden(true)
            .background(Color.white)
            //.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 120)
            .edgesIgnoringSafeArea(.bottom)
            
            HStack {
                Spacer()
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: 48, height: 5,alignment: .center)
                    .customRoundedRectangle()
                
                Spacer()
            }
            .padding(.vertical,10)
            }
            
            // Certificate Section
            VStack {
                Spacer()
                VStack(spacing: 0) {
                    Image("CertificateSmall", bundle: PackageManager.bundle)
                        .resizable()
                        .scaledToFit()
                    VStack(spacing: 20) {
                        Button {
                            withAnimation(.spring()) {
                                showCertificate.toggle()
                            }
                        } label: {
                            HStack {
                                Spacer()
                            Text("View Certificate")
                                .padding(9)
                                .foregroundColor(.darkPurple)
                                .font(.gtWalsheimBoldWithSizeBold16)
                                Spacer()

                            }
                            .background(Color.white)
                            .clipShape(Capsule())
                        }

                        Button {

                        } label: {
                            Text("View Course")
                                .foregroundColor(Color.white)
                            .font(.gtWalsheimBoldWithSizeBold16)
                            .overlay(
                                Rectangle()
                                    .frame(height: 2)
                                    .offset(y: 2)
                                    .foregroundColor(.white)
                                
                                , alignment: .bottom
                            )

                               // .background(Color.white)
                        }
                    }
                    .padding(30)
                    .background(Color.darkPurple)
              }


            }
            .edgesIgnoringSafeArea(.bottom)
//            .overlay(showCertificate ? CertificateBottomPopUp(showCertificate: $showCertificate)
//                        .padding(.horizontal, 10)
//                     : nil, alignment: .bottom
//            )
           // .background(Color.darkPurple)
            //.frame(width: UIScreen.main.bounds.width, height:300  )
            
            if showCertificate {
            CustomBottomPopUp(title: "",showContentView:$showCertificate,handleDragGesture: .constant(true),handleBgTapGesture:.constant(true), showTitle :  false,drawerColor: .white) {
                
                CertificateBottomPopUp(showCertificate: $showCertificate)
                    //.padding(.top, 30)

            }
            .edgesIgnoringSafeArea(.bottom)
            }
            
            
        }
        .shee(isPresented: $langData.showLangView,
              presentationStyle: .formSheet(properties: .init(detents: [ .medium() ], selectedDetentIdentifier: $selectedDetentIdentifier, animatesSelectedDetentIdentifierChange: true)),
              onDismiss: {}) {
            VStack {
                Text("Select a langauge")
                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_regular, fontSize: .large))
                    .padding()
                ScrollView {
                    VStack {
                        ForEach(0..<langData.LangArr.count){ i in
                            HStack {
                                Spacer()
                            Text(langData.LangArr[i])
                                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_regular, fontSize: .largemid))
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                Spacer()
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                langData.selectedLang = langData.LangArr[i]
                                langData.showLangView = true
//                                dismiss()
                            }
                            .background(langData.selectedLang == langData.LangArr[i] ? Color.lightPurple : Color.white )
                            .foregroundColor(langData.selectedLang == langData.LangArr[i] ? .darkPurple : .disableButton )
                            .customRoundedRectangle()
                        }
                    }
                }
                
                Button {
                    langData.showLangView = false
                } label: {
                    HStack {
                        Spacer()
                    Text("Save")
                        .font(.getCustomFontWithSize(fontType: .gt_walsheim_bold, fontSize: .regular))
                        .frame(height: 40)
                        Spacer()
                    }
                    .padding(8)
                    .background(Color.darkPurple)
                    .foregroundColor(Color.white)
                    .customRoundedRectangle()
                    
                }
            }
            .padding()
        }
//    onEnd: {
//            print("DISMISSED")
//        }
    }
}

@available(iOS 15.0, *)
struct CompletionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CompletionDetailsView()
    }
}
