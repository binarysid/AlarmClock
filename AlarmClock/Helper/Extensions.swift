//
//  Extensions.swift
//  HugeClock
//
//  Created by Linkon Sid on 29/1/23.
//

import SwiftUI

extension Date{
    func getTime(with format:String, dateFormatter: DateFormatter = DateFormatter.shared)->String{
        dateFormatter.dateFormat = format
        let time = dateFormatter.string(from: self)
        return time
    }
    func getTime(with timeZone:TimeZone, format:String,am:String,pm:String,
        dateFormatter: DateFormatter = DateFormatter.shared)->String{
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = format
        dateFormatter.amSymbol = am
        dateFormatter.pmSymbol = pm
        return dateFormatter.string(from: self)
    }
}
extension DateFormatter{
    static let shared = DateFormatter() // creating DateFormatter is an expensive operation according to Apple. This singleton will help to overcome the issue
}
extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
}
