//
//  CertificateBottomPopUp.swift
//  ABOAcademy
//
//  Created by Swapnil Tilkari on 11/03/22.
//

import SwiftUI

struct CertificateBottomPopUp: View {
    @Binding var showCertificate : Bool
    var body: some View {
      
        ZStack(alignment:.top) {
            Image("CertificateConfetti", bundle: PackageManager.bundle)
                .opacity(0.5)
            ZStack(alignment:.bottomTrailing) {
            VStack(alignment:.leading) {
                HStack {
                 Text("Certificate")
                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_bold, fontSize: .extraSmall))
                 Spacer()
                 Image("CloseBlackIcon", bundle: PackageManager.bundle)
                        .onTapGesture {
                            showCertificate.toggle()
                        }
                }
                
                Text("This is a really long course name these things can get ridiculous.")
                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_medium, fontSize: .xxxLarge))
                   
                    .fixedSize(horizontal:false, vertical: true)
                    .lineLimit(5)
                
                Text("Nancy Senatharang")
                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_medium, fontSize: .medium))
                
                Text("2022 Feb 22")
                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_medium, fontSize: .medium))
                
                    
               // Spacer()
            }
            .padding(16)
            .foregroundColor(.darkPurple)
                
            Image("Acheivement", bundle: PackageManager.bundle)
                    .padding(30)
            }
            
        }
      
        
    }
   
}

struct CertificateBottomPopUp_Previews: PreviewProvider {
    static var previews: some View {
        CertificateBottomPopUp(showCertificate: .constant(false))
    }
}
