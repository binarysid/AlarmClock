//
//  ClockCell.swift
//  AlarmClock
//
//  Created by Linkon Sid on 27/1/23.
//

import SwiftUI

struct ClockCell: View {
    var data:ClockViewData
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25,style: .continuous)
                .fill(.white)
                .shadow(radius: 10)
            HStack{
                VStack{
                    Text(data.timezone)
                }
                Spacer()
                VStack{
                    Text(data.time)
                }
            }
            .padding()
            .multilineTextAlignment(.leading)
        }
        .padding()
    }
}

struct ClockCell_Previews: PreviewProvider {
    static var previews: some View {
        ClockCell(data: ClockViewData(id: "", time: "", timezone: ""))
    }
}
