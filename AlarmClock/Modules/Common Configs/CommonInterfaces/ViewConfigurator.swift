//
//  Configurator.swift
//  HugeClock
//
//  Created by Linkon Sid on 26/1/23.
//

import SwiftUI

// This protocol is for configuring views. Defines relationships between each component of a domain
protocol ViewConfigurator{
    associatedtype T:View
    func configure()->T
}


