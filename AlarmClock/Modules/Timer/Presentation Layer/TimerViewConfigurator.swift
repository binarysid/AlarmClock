//
//  TimerViewConfigurator.swift
//  HugeClock
//
//  Created by Linkon Sid on 26/1/23.
//

import SwiftUI

struct TimerViewConfigurator:ViewConfigurator{
    func configure() -> some View {
        registerDependency()
        let viewModel = TimerViewModel()
        return TimerView(viewModel: viewModel)
    }
    private func registerDependency(){
        let container = DIContainer.shared
        container.register(type: TimerInputValidatorProtocol.self, component: TimerInputValidator())
        container.register(type: TimerDataProcessorProtocol.self, component: TimerDataProcessor())
        container.register(type: TimerWatchable.self, component: CountDownEngine())
        container.register(type: CountDownUseCaseProtocol.self, component: TimerUseCase(queue: OperationQueue()))
    }
}
