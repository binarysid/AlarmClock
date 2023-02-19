//
//  Injector.swift
//  AlarmClock
//
//  Created by Linkon Sid on 18/2/23.
//

import Foundation

@propertyWrapper
struct Inject<T>{
    let wrappedValue:T
    init(){
        self.wrappedValue = DIContainer.shared.resolve(type: T.self)
    }
}
