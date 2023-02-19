//
//  AlarmViewConfigurator.swift
//  AlarmClock
//
//  Created by Linkon Sid on 29/1/23.
//

import SwiftUI

struct AlarmViewConfigurator:ViewConfigurator{
    
    func configure() -> some View {
        registerDependency()
        let router = AlarmRouter()
        var presenter = AlarmPresenter()
        let interactor = AlarmInteractor()
        let controller = AlarmController(router: router)
        presenter.view = controller
        interactor.presenter = presenter
        controller.interactor = interactor
        return AlarmView(controller: controller)
    }
    private func registerDependency(){
        let container = DIContainer.shared
        container.register(type: AlarmLocalDataSourceProtocol.self, component: AlarmLocalDataSource(mainContext: .Main(CoreDataStack.mainContext), backgroundContext: .Background(CoreDataStack.backgroundContext)))
        container.register(type: AlarmRepositoryProtocol.self, component: AlarmRepository())
        container.register(type: AlarmDataServiceWorkable.self, component: AlarmDataServiceWorker())
        container.register(type: AlarmNotificationWorkerProtocol.self, component: AlarmNotificationWorker())
    }
}
