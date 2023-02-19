//
//  ClockViewConfigurator.swift
//  AlarmClock
//
//  Created by Linkon Sid on 27/1/23.
//

import SwiftUI

struct ClockViewConfigurator: ViewConfigurator {
    func configure() -> some View {
        registerDependency()
        let viewModel = ClockViewModel()
        return ClockView(viewModel: viewModel)
    }
    private func registerDependency(){
        let container = DIContainer.shared
        container.register(type: ClockSchedulerUseCaseProtocol.self, component: ClockSchedulerUseCase(queue: OperationQueue()))
        container.register(type: ClockDataSource.self, component: ClockLocalDataSource())
        container.register(type: ClockFetchDataUseCaseProtocol.self, component: ClockFetchDataUseCase(repository: ClockRepository()))
    }
}
