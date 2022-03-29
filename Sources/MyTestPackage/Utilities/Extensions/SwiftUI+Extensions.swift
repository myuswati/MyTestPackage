//
//  SwiftUI+Extensions.swift
//  ABOAcademy
//
//  Created by Shrinivas Reddy on 19/01/22.
//

import SwiftUI
import Amway_Base_Utility
//ABO Academy Custom Fonts

extension Font {
    
    static var gtWalsheimBoldWithSizeRegular14: Font {
        return self.custom(customFont.gt_walsheim_regular.rawValue, size: customFontSize.regular.rawValue)
    }
    
    static var gtWalsheimBoldWithSizeRegular16: Font {
        return self.custom(customFont.gt_walsheim_regular.rawValue, size: customFontSize.medium.rawValue)
    }
    
    static var gtWalsheimMediumWithSizeMedium14: Font {
        return self.custom(customFont.gt_walsheim_medium.rawValue, size: customFontSize.regular.rawValue)
    }
    
    static var gtWalsheimMediumWithSizeMedium16: Font {
        return self.custom(customFont.gt_walsheim_medium.rawValue, size: customFontSize.medium.rawValue)
    }
    
    static var gtWalsheimBoldWithSizeBold14: Font {
        return self.custom(customFont.gt_walsheim_bold.rawValue, size: customFontSize.regular.rawValue)
    }
    
    static var gtWalsheimBoldWithSizeBold16: Font {
        return self.custom(customFont.gt_walsheim_bold.rawValue, size: customFontSize.medium.rawValue)
    }
    
    static var gtWalsheimBoldWithSizeBold24: Font {
        return self.custom(customFont.gt_walsheim_bold.rawValue, size: customFontSize.vvLarge.rawValue)
    }
    
    // custom font handling tool
    static func getCustomFontWithSize( fontType: customFont, fontSize : customFontSize) -> Font {
        return self.custom(fontType.rawValue, size: fontSize.rawValue)
    }
    
}

enum customFontSize : CGFloat {
    /// size 8
    case vvvsmall = 8
    /// size 10
    case extraSmall = 10
    /// size 11
    case verySmall = 11
    /// size 12
    case small = 12
    /// size 13
    case mediumSmall = 13
    /// size 14
    case regular = 14
    /// size 15
    case semimedium = 15
    /// size 16
    case medium = 16
    /// size 18
    case large = 18
    /// size 20
    case largemid = 20
    /// size 21
    case vlargemid = 21
    /// size 22
    case vLarge = 22
    /// size 24
    case vvLarge = 24
    /// size 26
    case xLarge = 26
    /// size 28
    case xxLarge = 28
    /// size 32
    case xxxLarge = 32
    /// size 36
    case xxxxLarge = 36
    
    /// size 53
    case xxxxxLarge = 50
}

enum customRegularFontSize: CGFloat {
    case regular14 = 14
    case regular16 = 16
}

enum customMediumFontSize: CGFloat {
    
    case medium14 = 14
    case medium16 = 16
}

enum customBoldFontSize: CGFloat {
    
    case bold14 = 14
    case bold16 = 16
    case bold24 = 24
}

enum customFont: String {
    
    case gt_walsheim_bold = "GTWalsheimProBold"
    case gt_walsheim_medium = "GTWalsheimProMedium"
    case gt_walsheim_regular = "GTWalsheimProRegular"
}


//ABO Academy Color Extension

extension Color {
    static let amwayBlack: Color = Color("AmwayBlack") // Color(red: 44/255, green: 44/255, blue: 44/255)
    static let darkGray: Color = Color("DarkGray") //Color(red: 112/255, green: 112/255, blue: 112/255)
    static let alertOrange: Color = Color("AlertOrange") //Color(red: 163/255, green: 106/255, blue: 0/255)
    static let alertLightOrange: Color = Color("AlertLightOrange") //Color(red: 255/255, green: 249/255, blue: 240/255)
    static let darkPurple: Color = Color("DarkPurple") //Color(red: 56/255, green: 83/255, blue: 154/255)
    static let lightPurple: Color = Color("LightPurple") //Color(red: 241/255, green: 242/255, blue: 255/255)
    static let darkGreen: Color = Color("DarkGreen") //Color(red: 84/255, green: 98/255, blue: 35/255)
    static let lightGreen: Color = Color("LightGreen") //Color(red: 240/255, green: 250/255, blue: 229/255)
    static let outlinePurple: Color = Color("OutlinePurple") //Color(red: 148/255, green: 163/255, blue: 205/255)
    static let backGround: Color = Color(red: 228/255, green: 228/255, blue: 228/255)
    static let exploreBackGround: Color = Color("ExploreBackground")
    static let amwayWhite: Color = Color("AmwayWhite")
    static let lightGray: Color = Color("LightGray")
    
    static let disableButton: Color = Color("DisableButton")
    
}

///Custom views
extension View {
    
    func customShadow(frontColor:Color,BackColor: Color) -> some View {
        self.shadow(color: frontColor, radius: 4, x: 4, y: 4)
            .shadow(color: BackColor, radius: 4, x: -4, y: -4)
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        self.clipShape(CornerRadiusShape(radius: radius, corners: corners) )
    }
    
    func customRoundedRectangle(cornerRadius: CGFloat = 12.0) -> some View {
        self.clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }
    
    func customBorder( color: Color = .darkGray, cornerRadius : CGFloat = 8, opacity: Double = 1) -> some View {
        self.overlay(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous).stroke(color.opacity(opacity), lineWidth: 2))
    }
    
    func customCircleBorder(color: Color = .darkGray, lineWidth : CGFloat = 2) -> some View {
        self.overlay(Circle().stroke(color, lineWidth: lineWidth))
    }
    
    func customCapsuleBorder(color: Color = .darkGray, lineWidth : CGFloat = 2) -> some View {
        self.overlay(Capsule().stroke(color, lineWidth: lineWidth))
    }
    
    func customRoundedRectangleOverlay(cornerRadius:CGFloat, color: Color = .white, lineWidth : CGFloat = 2) -> some View {
        self.overlay(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous).strokeBorder(color, lineWidth: lineWidth))
    }
    
    //other custom prpoerty example
    //    func customTitleTextType1(input:String,color:Color) -> some View {
    //        Text(input)
    //            .foregroundColor(color)
    //            .font(.customMediumFontWithSizeRegular)
    //    }
    
}

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

/// Use this struct to set corner radius to any of the given corners.
///
struct CornerRadiusShape: Shape {
    
    var radius = CGFloat.infinity
    var corners = UIRectCorner.allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}

extension UIApplication {

    func applicationVersion() -> String {

        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }

    func applicationBuild() -> String {

        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }

    func versionBuild() -> String {

        let version = Amway_Base_Utility.CommonUtils.fetchBuildVersion()
        let build = Amway_Base_Utility.CommonUtils.getAppBuildNo()

        return "v\(version)(\(build))"
    }
}
