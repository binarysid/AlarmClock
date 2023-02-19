//
//  ActionButton.swift
//  AlarmClock
//
//  Created by Linkon Sid on 30/1/23.
//

import SwiftUI

struct ActionButton: View {
    var titleText:String
    var body: some View {
        Text(titleText)
            .foregroundColor(.purple)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.purple, lineWidth: 5)
                    )
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(titleText: "Start")
    }
}
