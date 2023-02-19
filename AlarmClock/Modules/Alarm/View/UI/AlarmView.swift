//
//  AlarmView.swift
//  AlarmClock
//
//  Created by Linkon Sid on 29/1/23.
//

import SwiftUI

struct AlarmView<T:AlarmViewInput>: View {
    @ObservedObject var controller:T
    @State var selectedTime = Date()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading,spacing: 20){
                alarmAddSection()
                loader()
                viewList()
            }
            .padding()
        }
        .onAppear(perform:{
            controller.fetchAlarmList()
        })
    }
}

extension AlarmView{
    func alarmAddSection()->some View{
        Form{
            Section(header: Text(AppConstants.Alarm.ActionMessage.AddAlarmSectionTitle)){
                DatePicker(AppConstants.Alarm.ActionMessage.TimePickerTitle, selection: $selectedTime,in: Date()..., displayedComponents: .hourAndMinute) // future date selection
                Button(AppConstants.Alarm.ActionMessage.CreateButtonTitle){
                    controller.createAlarm(with: selectedTime)
                }
            }
        }
    }
    func viewList()->some View{
        List {
            ForEach($controller.viewData) { $data in
                AlarmListCell(data: data){viewData in
                    controller.updateAlarmWith(data: viewData)
                }
                .swipeActions(){
                    Button(AppConstants.Alarm.ActionMessage.SwipeDeleteTitle){
                        controller.deleteAlarmWith(data: data)
                    }
                    .tint(.red)
                }
                .listRowBackground(Color.clear)
                .listRowInsets(.init())
            }
        }
        
        .background(Color.clear)
        .listStyle(PlainListStyle())
    }
    func loader()->some View{
        ProgressLoader(tintColor: .black, scaleSize: 2.0)
            .padding(.bottom,50)
            .hidden(!controller.isLoading)
    }
}
struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmViewConfigurator().configure()
    }
}
