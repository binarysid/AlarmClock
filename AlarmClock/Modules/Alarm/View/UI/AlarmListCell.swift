//
//  AlarmListCell.swift
//  AlarmClock
//
//  Created by Linkon Sid on 29/1/23.
//

import SwiftUI

struct AlarmListCell: View {
    @State var data:AlarmViewData
    let onChangingState: (AlarmViewData) -> Void // for triggering action from parent view
    
    var body: some View {
        ZStack {
            Color.clear
            HStack{
                Text(data.time)
                Toggle("", isOn: $data.isEnabled)
                    .onChange(of: data.isEnabled){ value in
                        onChangingState(data)
                    }
            }
        }
    }
}

//struct AlarmListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        @State let data = AlarmViewData(id: UUID(), time: "22:30", isEnabled: true)
//        AlarmListCell(data: $data)
//    }
//}
