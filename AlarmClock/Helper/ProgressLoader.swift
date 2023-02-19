//
//  ProgressLoader.swift
//  AlarmClock
//
//  Created by Linkon Sid on 29/1/23.
//

import SwiftUI

struct ProgressLoader: View {
    var tintColor: Color = .blue
    var scaleSize: CGFloat = 1.0
    
    var body: some View {
        ProgressView()
            .scaleEffect(scaleSize, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
    }
}
