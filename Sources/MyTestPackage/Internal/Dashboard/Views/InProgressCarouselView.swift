//
//  InProgressCarouselView.swift
//  ABOAcademy
//
//  Created by Shrinivas Reddy on 10/02/22.
//

import SwiftUI

struct InProgressCarouselView: View {
    
    @State private var index = 0
    
    var body: some View {
        VStack(spacing: 16) {
            TabView(selection: $index) {
                ForEach((0..<3), id: \.self) { index in
                    InProgressCardView()
                        
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 350)
            
            HStack(spacing: 12) {
                ForEach((0..<3), id: \.self) { index in
                    Circle()
                        .fill(index == self.index ? Color.darkPurple : Color.outlinePurple)
                        .frame(width: 8, height: 8)

                }
            }
//            .padding()
            Spacer()
        }
        .frame(maxWidth: 600)
    }
}

//struct InProgressView: View {
//
//    @State private var index = 0
//
//    var body: some View {
//
//        VStack {
//            TabView(selection: $index) {
//                ForEach((0..<3), id: \.self) { index in
//                    InProgressCardView()
//                        .frame(height: 350)
//                }
//            }
//            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//        }
//    }
//}

struct InProgressCardView: View {
    
    private var courseImageURL: String = ""
    private var courseTitle: String = "Selling Balance Within™️ Probiotics to Build Your Business Probiotics to Build"
    private var courseDuration: String = "1h 15m"
    private var coursesCount: String = "10 Courses"
    @State var progressValue: Float = 0.1
    
    var body: some View {
        
        VStack(alignment: .leading) {
            ZStack(alignment: .top) {
                Image("InProgress", bundle: PackageManager.bundle)
                .resizable()
                .frame(height: 162)
//Uncomment below code once we get the image URL from the API.
//                    AsyncImage(url: URL(string: "https://assetscdn1.paytm.com/images/catalog/product/L/LA/LAPGANDIVA-ECONNALL1088566365C7F92/1615367285787_0..jpg?imwidth=320&impolicy=hq"), content: { image in
//                            image.resizable()
//                                 .aspectRatio(contentMode: .fit)
////                                 .frame(maxWidth: 300, maxHeight: 100)
//                        },
//                        placeholder: {
//                          ProgressView()
//                        }
//                    )
                
              //  VStack{
                    HStack {
                        Spacer()
                        Button {
                            print("Delete Button pressed")
                        } label: {
                            
                            Image("CloseBlackIcon", bundle: PackageManager.bundle)
                                .padding(12)
                                .background(Color.white)
                                .frame(width: 25, height: 25)
                                .clipShape(Circle())
                        }
                        .padding([.top, .trailing], 12)
                    }
                //}
            }
            
            VStack(alignment: .leading) {
                
            Text(courseTitle)
                .font(.getCustomFontWithSize(fontType: .gt_walsheim_bold, fontSize: .vvLarge))
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(3)
                .foregroundColor(.amwayBlack)
                
                
            
            HStack(alignment: .center) {
                
                Label(courseDuration, image: "LoadIcon")
                    .font(.gtWalsheimMediumWithSizeMedium14)
                    .foregroundColor(.darkPurple)
                  
                
                ProgressBar(value: $progressValue)
                    .frame(height: 10)
                   
                Spacer()
                HStack(spacing: 4) {
                    
                    Image("FavIcon", bundle: PackageManager.bundle)
                        .resizable()
                        .frame(width: 24, height: 24)
                    
                   
                        Image("DownloadIcon", bundle: PackageManager.bundle)
                            .resizable()
                            .frame(width: 24, height: 24)
                }
            }
           
            }
            .padding(16)
        }
        .background(Color.white)
        .cornerRadius(12)
    }
}

struct ProgressBar: View {
    @Binding var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color.darkPurple)
                    .animation(.linear, value: value)
            }
            .cornerRadius(5.0)
        }
    }
}

struct InProgressCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        InProgressCarouselView()
    }
}
