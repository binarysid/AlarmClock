//
//  ContentView.swift
//  HugeClock
//
//  Created by Linkon Sid on 24/1/23.
//

import SwiftUI

struct ClockView<T:ClockViewModelProtocol>: View {
    @ObservedObject var viewModel: T
    var body: some View {
        NavigationView{
            clockList()
        }
        .onAppear(perform:viewModel.startClock)
    }
}

extension ClockView{
    func clockList()->some View{
        List(viewModel.viewData) { data in
            ClockCell(data: data)
                .listRowBackground(Color.clear)
                .listRowInsets(.init())
        }
        .background(Color.clear)
        .listStyle(PlainListStyle())
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ClockViewConfigurator().configure()
    }
}
