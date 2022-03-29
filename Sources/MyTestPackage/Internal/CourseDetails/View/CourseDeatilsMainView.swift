//
//  CourseDeatilsMainView.swift
//  ABOAcademy
//
//  Created by Swapnil Tilkari on 24/02/22.
//

import SwiftUI
import SheeKit

@available(iOS 15, *)
@available(iOS 15.0, *)
@available(iOS 15.0, *)
struct CourseDeatilsMainView: View {
    
    var course : CourseModel = CourseModel()
    @StateObject var langData = LangViewModel.shared
    @StateObject var syllabusData = CourseDetailsMainViewModel.shared
    @State private var selectedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = UISheetPresentationController.Detent.Identifier.medium
    
    var body: some View {
        
        ZStack {
            ZStack(alignment:.top) {
              
            VStack(alignment: .leading, spacing: 0) {
                ScrollView {
                    VStack {
                        CourseDetailsView(showLangView: $langData.showLangView, selectedLang: $langData.selectedLang, course:course)
                        
                        AchivementView()
                            .padding(.horizontal,16)
                        
                        SyllabusView(courseData: syllabusData)
                            .padding(16)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Related Courses")
                                .font(.getCustomFontWithSize(fontType: .gt_walsheim_bold, fontSize: .medium))
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(0..<4){ i in
                                        
                                        CourseCardView(course: .constant(course))
                                            .frame(width: 284)
                                            .customShadow(frontColor: .black.opacity(0.1), BackColor: .white)
                                            .padding(.vertical, 16)
                                        
                                    }
                                }
                                
                            }
                        }
                        .padding(.leading, 16)
                    }
                    
                }
                VStack {
                    Button {
                        
                    } label: {
                        HStack{
                            Spacer()
                            Text("Start Course")
                                .font(.getCustomFontWithSize(fontType: .gt_walsheim_bold, fontSize: .regular))
                            Spacer()
                        }
                        
                    }
                    .frame(height: 36)
                    .background(Color.black)
                    .foregroundColor(Color.white)
                    .customRoundedRectangle()
                    
                    
                }
                .padding(16)
                .frame(width: UIScreen.main.bounds.width, height: 68)
                .background(Color.white)
                .customRoundedRectangle()
                
                
                
                
            }
            .navigationBarHidden(true)
            .background(Color.white)
           // .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 120)
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
    }
}




struct SyllabusView: View {
    @ObservedObject var courseData : CourseDetailsMainViewModel
    @State var showSection : Bool = true
    var courseCompleteion : Bool = false
    
    var body: some View {
        
        VStack(alignment:.leading,spacing: 16) {
            
            HStack {
                Text("Syllabus")
                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_bold, fontSize: .medium))
                Spacer()
                
                if courseCompleteion {
                    Image("Chevron", bundle: PackageManager.bundle)
                        .rotationEffect(showSection ? .degrees(180): .degrees(0))
                        .onTapGesture {
                            showSection.toggle()
                        }
                }
            }
            
            if showSection {
                if courseData.syllabus.count > 0 {
                    
                    ForEach(0..<courseData.syllabus.count,id:\.self) { i in
                        
                        HStack(spacing: 12) {
                            Text("Section \(i + 1): \(courseData.syllabus[i].header)")
                                .font(.getCustomFontWithSize(fontType: .gt_walsheim_medium, fontSize: .regular))
                            
                            Spacer()
                            Image("Chevron", bundle: PackageManager.bundle)
                                .rotationEffect(courseData.syllabus[i].showSection ? .degrees(180): .degrees(0))
                                .onTapGesture {
                                    courseData.syllabus[i].showSection.toggle()
                                }
                            
                        }
                        if courseData.syllabus[i].showSection {
                            VStack(spacing: 8) {
                                ForEach(0..<courseData.syllabus[i].syllabusData.count,id:\.self){ j in
                                    
                                    SyllabusCellView(data: $courseData.syllabus[i].syllabusData[j])
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}

struct SyllabusCellView: View {
    
    @Binding var data : SyllabusData
    
    var body: some View {
        
        HStack{
            Text("1.")
                .font(.getCustomFontWithSize(fontType: .gt_walsheim_medium, fontSize: .regular))
            
            VStack(alignment:.leading) {
                Text("Video Title")
                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_medium, fontSize: .regular))
                
                Text("Runtime – 3:01 mins")
                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_regular, fontSize: .regular))
            }
            
            Spacer()
            
            VStack(alignment:.leading) {
                Spacer()
                
                Image("Video", bundle: PackageManager.bundle)
                
                Spacer()
            }
            
            
            
        }
        .padding(16)
        .frame(maxWidth:.infinity)
        .frame(height: 50)
        .background(Color.lightGray)
        .customRoundedRectangle()
        
        
    }
    
}


struct AchivementView: View {
    
    var courseCompleteion : Bool = false
    @State var showSection : Bool = true
    var body: some View {
        
        VStack(alignment:.leading,spacing: 16) {
            
            VStack(alignment:.leading,spacing: 4) {
                HStack(spacing: 8){
                    Text("Achievements")
                        .font(.getCustomFontWithSize(fontType: .gt_walsheim_bold, fontSize: .medium))
                    Image("QuestionMark", bundle: PackageManager.bundle)
                    Spacer()
                    if courseCompleteion {
                        Image("Chevron", bundle: PackageManager.bundle)
                            .rotationEffect(showSection ? .degrees(180): .degrees(0))
                            .onTapGesture {
                                showSection.toggle()
                            }
                    }
                }
                
                if  showSection {
                    Text("By completing courses you gain the achievements listed below.")
                        .font(.getCustomFontWithSize(fontType: .gt_walsheim_regular, fontSize: .regular))
                }
            }
            if  showSection {
                HStack{
                    Image("Acheivement", bundle: PackageManager.bundle)
                        .frame(width: 65, height: 65)
                    
                    Text(courseCompleteion ? "  View Earned Certificate" : "Certificate for Completion")
                        .font(.getCustomFontWithSize(fontType: .gt_walsheim_regular, fontSize: .regular))
                    Spacer()
                    
                }
                .padding(16)
                .frame(maxWidth:.infinity)
                .frame(height: 105)
                .foregroundColor(.white)
                .background(Color.darkPurple)
                .customRoundedRectangle()
                
            }
            
            
        }
        
    }
    
}

@available(iOS 15.0, *)
struct CourseDeatilsMainView_Previews: PreviewProvider {
    static var previews: some View {
        CourseDeatilsMainView()
    }
}
