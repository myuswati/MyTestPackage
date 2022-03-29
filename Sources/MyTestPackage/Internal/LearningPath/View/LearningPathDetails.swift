//
//  LearningPathDetails.swift
//  ABOAcademy
//
//  Created by Swapnil Tilkari on 23/02/22.
//

import SwiftUI

struct LearningPathDetails: View {
    var course : CourseModel = CourseModel()
  
    @Environment(\.presentationMode) var presentation
    @StateObject var langData = LangViewModel.shared
    
    var LangArr = ["English","Chineese","Japneese","Spanish","Russian"]
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0){
                
                CustomNavBar(navBarTitle: "Learning Path", showRightNavButton: false) {
                    presentation.wrappedValue.dismiss()
                } rightBarAction: {
                    
                }
                
                ScrollView {
                    
                    CourseDetailsView(showLangView: $langData.showLangView, selectedLang: $langData.selectedLang, course: course,isLearning: true)
                    
                   
                    
                    VStack(alignment:.leading, spacing: 16) {
                        
                        Text("Courses in This Learning Path")
                            .font(.getCustomFontWithSize(fontType: .gt_walsheim_bold, fontSize: .medium))
                        
                        ForEach((0..<3), id: \.self) { index in
                            
                           // InProgressCardView()
                            CourseCardView(course: .constant(course))
                                .customShadow(frontColor: .black.opacity(0.2), BackColor: .white)
                                //.padding(.vertical, 16)
                        }
                        
                    }
                    .padding(16)
                }
                
                
                
            }
            .navigationBarHidden(true)
            .background(Color.white)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            if langData.showLangView {
                LangSelectorCustomPopUp(langData: langData)
            }
        }
        
    }
}

struct LangSelectorCustomPopUp : View {
    
    @ObservedObject var langData: LangViewModel
    
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            CustomBottomPopUp(title: "", showContentView: $langData.showLangView, handleDragGesture: .constant(true), handleBgTapGesture: .constant(true),showTitle: false,drawerColor: .black,showDrawerInZStack: false) {
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
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
                                ///showLangView = false
                            }
                            .background(langData.selectedLang == langData.LangArr[i] ? Color.lightPurple : Color.white )
                            .foregroundColor(langData.selectedLang == langData.LangArr[i] ? .darkPurple : .disableButton )
                            .customRoundedRectangle()
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Spacer()
                        Text("Save")
                            .font(.getCustomFontWithSize(fontType: .gt_walsheim_bold, fontSize: .regular))
                            Spacer()
                        }
                        .padding(8)
                        .background(Color.darkPurple)
                        .foregroundColor(Color.white)
                        .customRoundedRectangle()
                        
                    }
                   

                }
                .frame(height: 300)
            }
        }
    }
}

struct LearningPathDetails_Previews: PreviewProvider {
    static var previews: some View {
        LearningPathDetails()
    }
}




