//
//  WelcomeVideoCardView.swift
//  ABOAcademy
//
//  Created by Shrinivas Reddy on 21/01/22.
//

import SwiftUI
import AVKit

struct WelcomeVideoCardView: View {
    
    var welcomeTitle: String = "Welcome to ABO Academy"
    var welcomeVideoUrl: String = "video.mp4"

    var body: some View {
        VStack {
           // Spacer()
            HStack {
                Text(welcomeTitle)
                    .foregroundColor(.white)
                    .font(.gtWalsheimBoldWithSizeBold24)
                Spacer()
            }
            Spacer()
                .frame(height: 16)
            let videoURL: URL = Bundle.main.url(forResource: "video", withExtension: "mp4")!
            
            VideoPlayer(player: AVPlayer(url:  videoURL)) {
            }
            
//            .overlay(Image("PlayPauseIcon", bundle: .module)
//                        .resizable()
//                        .frame(width: 60, height: 60))
            .customRoundedRectangle()
            .frame(height: 192)
        }
        .padding(.horizontal, 16)
        .padding(.top, 40)
        .padding(.bottom, 24)
        .background(Color.darkPurple)
    }
}

struct WelcomeVideoCardView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeVideoCardView()
    }
}
