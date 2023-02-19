//
//  SplashView.swift
//  HugeClock
//
//  Created by Linkon Sid on 30/1/23.
//

import SwiftUI

struct SplashView: View {
    @State var isActive = false
    var body: some View {
        VStack {
            if self.isActive {
                RootView()
            } else {
                Image(systemName: AppConstants.Common.SplashImage)
                    .renderingMode(.original)
                    .font(.largeTitle)
                    .padding()
                    .clipShape(Circle())
            }
        }
        .onAppear {
            // load main view after 1 sec
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
    
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}

