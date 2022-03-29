//
//  CheckboxField.swift
//  ABOAcademy
//
//  Created by Shrinivas Reddy on 09/03/22.
//

import SwiftUI


//MARK:- Checkbox Field
struct CheckboxField: View {
    var size: CGFloat = 20
    var color: Color = Color.black
    @Binding var subcategoryFilter: SubCategory
    var callback: (SubCategory)->()?
//    var isAlreadySelected: Bool = false
    
    var body: some View {
        Button(action:{
            subcategoryFilter.isMarked.toggle()
            callback(self.subcategoryFilter)
        }) {
            HStack(alignment: .center, spacing: 4) {
                   
                Image(subcategoryFilter.count > 0 ? (self.subcategoryFilter.isMarked ? "FilledCheckboxIcon" : "EmptyCheckboxIcon") : "DisableCheckboxIcon", bundle: PackageManager.bundle)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                
                Text("\(subcategoryFilter.title) (\(subcategoryFilter.count))")
                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_medium, fontSize: .regular))
                    .foregroundColor(subcategoryFilter.count > 0 ? (self.subcategoryFilter.isMarked ? .darkPurple : .amwayBlack) : .darkGray)
                
                Spacer()
            }
            .foregroundColor(self.color)
        }
        .foregroundColor(Color.white)
    }
}


