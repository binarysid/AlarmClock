//
//  TimerView.swift
//  HugeClock
//
//  Created by Linkon Sid on 26/1/23.
//

import SwiftUI

struct TimerView<T:TimerViewModelProtocol>: View {
    @ObservedObject var viewModel: T
    @State private var hour: String = "0"
    @State private var minute: String = "0"
    @State private var second: String = "0"
    
    var body: some View {
        VStack(){
            inputView()
            periodicTimerView()
            buttonViews()
        }
    }
    
}
extension TimerView{
    func buttonViews()->some View{
        Section(header: Text("").font(.title)) {
            HStack{
                Button(action: {
                    switch viewModel.getState() {
                    case .Inactive, .Suspended:
                        viewModel.startTimer(hour: self.hour, minute: self.minute, second: self.second)
                    case .Active:
                        viewModel.pauseTimer()
                    case .Paused:
                        print("paused")
                        //                    viewModel.resumeTimer()
                    }
                    
                }, label: {
                    switch viewModel.getState()  {
                    case .Inactive, .Suspended, .Active:
                        ActionButton(titleText: AppConstants.Timer.ActionMessage.StartButtonTitle)
                    case .Paused:
                        ActionButton(titleText: AppConstants.Timer.ActionMessage.ResumeButtonTitle)
                    }
                })
                    .alert(isPresented: $viewModel.showValidationAlert) {
                        Alert(title: Text(AppConstants.Timer.ErrorMessage.InvalidRangeTitle), message: Text(AppConstants.Timer.ErrorMessage.InvalidRangeBody(viewModel.getHourLimit())), dismissButton: .default(Text(AppConstants.Timer.ActionMessage.AlertConfirmationButtonTitle)))
                    }
                    .disabled(viewModel.getState() == .Active)
                    .padding(4)
                Button(action: {
                    viewModel.stopTimer()
                }, label: {
                    ActionButton(titleText: AppConstants.Timer.ActionMessage.StopButtonTitle)
                })
                    .disabled(viewModel.getState() != .Active)
            }
        }
        .padding()
    }
    func periodicTimerView()->some View{
        Section(header: Text("Result Timer").font(.title)) {
            HStack{
                Text((viewModel.viewData?.hour ?? "00") + ":")
                    .font(.largeTitle)
                Text((viewModel.viewData?.minute ?? "00") + ":")
                    .font(.largeTitle)
                Text(viewModel.viewData?.second ?? "00")
                    .font(.largeTitle)
            }
        }.padding()
    }
    func inputView()->some View{
        Section(header: Text("Provide hour, minute and seconds").font(.title)) {
            HStack{
                TextField(viewModel.viewData?.hour ?? "0", text: $hour)
                    .keyboardType(.numberPad)
                    .disabled(viewModel.getState() == .Active)
                    .textFieldStyle(.roundedBorder)
                TextField(viewModel.viewData?.minute ?? "0", text: $minute)
                    .keyboardType(.numberPad)
                    .disabled(viewModel.getState() == .Active)
                    .textFieldStyle(.roundedBorder)
                TextField(viewModel.viewData?.second ?? "0", text: $second)
                    .keyboardType(.numberPad)
                    .disabled(viewModel.getState() == .Active)
                    .textFieldStyle(.roundedBorder)
            }
        }.padding()
    }
}
struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerViewConfigurator().configure()
    }
}
