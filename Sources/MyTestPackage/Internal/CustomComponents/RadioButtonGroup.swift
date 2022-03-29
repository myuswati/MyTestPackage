//
//  RadioButtonGroup.swift
//  ABOAcademy
//
//  Created by Shrinivas Reddy on 25/02/22.
//

import SwiftUI

struct ColorInvert: ViewModifier {

    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        Group {
            if colorScheme == .dark {
                content.colorInvert()
            } else {
                content
            }
        }
    }
}

struct RadioButton: View {

    @Environment(\.colorScheme) var colorScheme

    let id: String
    let callback: (String)->()
    let selectedID : String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat

    init(
        _ id: String,
        callback: @escaping (String)->(),
        selectedID: String,
        size: CGFloat = 20,
        color: Color = Color.primary,
        textSize: CGFloat = 14
        ) {
        self.id = id
        self.size = size
        self.color = color
        self.textSize = textSize
        self.selectedID = selectedID
        self.callback = callback
    }

    var body: some View {
        Button(action:{
            self.callback(self.id)
        }) {
            HStack(alignment: .center, spacing: 8) {
                Image(self.selectedID == self.id ? "OvalIcon" : "OvalEmptyIcon", bundle: PackageManager.bundle)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                    .modifier(ColorInvert())
                Text(id)
                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_medium, fontSize: .medium))
                    .foregroundColor(self.selectedID == self.id ? .darkPurple : .amwayBlack)
                Spacer()
            }
        }
    }
}

struct RadioButtonGroup: View {

    let items : [String]

    @State var selectedId: String = ""

    let callback: (String) -> ()

    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            ForEach(0..<items.count) { index in
                RadioButton(self.items[index], callback: self.radioGroupCallback, selectedID: self.selectedId)
            }
        }
    }

    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
}

//struct ContentView: View {
//    var body: some View {
//        HStack {
//            Text("Example")
//                .font(Font.headline)
//                .padding()
//            RadioButtonGroup(items: ["Rome", "London", "Paris", "Berlin", "New York"], selectedId: "London") { selected in
//                print("Selected is: \(selected)")
//            }
//        }.padding()
//    }
//}

struct RadioButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonGroup(items: MyCoursesSortByFilter.allCases.map { $0.rawValue }, selectedId: MyCoursesSortByFilter.allCases[0].rawValue) { selected in
            print("Selected is: \(selected)")
        }
    }
}
