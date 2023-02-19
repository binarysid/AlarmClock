//
//  CreateAlarm.swift
//  AlarmClock
//
//  Created by Linkon Sid on 28/1/23.
//

import Foundation

protocol RequestFactoryProtocol{
    associatedtype Input
    associatedtype Output
    func build(input:Input)->Output
}

struct RequestFactory {
    static func create<Output, Input, RequestFactory: RequestFactoryProtocol>(_ object: RequestFactory,_ configuration: Input) -> Output where RequestFactory.Output == Output,
                                                                                                                                               RequestFactory.Input == Input
    {
        object.build(input: configuration)
    }
}
