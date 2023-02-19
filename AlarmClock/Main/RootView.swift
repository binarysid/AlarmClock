//
//  RootView.swift
//  AlarmClock
//
//  Created by Linkon Sid on 30/1/23.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationView {
            TabView{
                ClockViewConfigurator().configure()
                    .tabItem{
                        Label(AppConstants.TabItem.TitleText.Clock,systemImage: AppConstants.TabItem.Icon.Clock)
                    }
                TimerViewConfigurator().configure()
                    .tabItem{
                        Label(AppConstants.TabItem.TitleText.Timer,systemImage: AppConstants.TabItem.Icon.Timer)
                    }
                AlarmViewConfigurator().configure()
                    .tabItem{
                        Label(AppConstants.TabItem.TitleText.Alarm,systemImage: AppConstants.TabItem.Icon.Alarm)
                    }
            }
        }
        .navigationBarTitle(Text(AppConstants.Common.AppTitle))
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
