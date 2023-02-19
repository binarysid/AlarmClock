//
//  LocalDataSourceTest.swift
//  HugeClockTests
//
//  Created by Linkon Sid on 26/1/23.
//

import XCTest
import CoreData
import Combine
@testable import HugeClock

class AlarmLocalDataSourceTest: XCTestCase {
    var sut: AlarmLocalDataSource!
    var createRequestMock:CreateAlarmRequestor!
    var fetchRequestMock:FetchAllAlarmRequestor!
    var expectation: XCTestExpectation!
    var cancellable = Set<AnyCancellable>()
    var persistenceContainer = CoreDataStackTest.shared.persistentContainer
    private var mainContext:NSManagedObjectContext{
        CoreDataStackTest.shared.mainContext
    }
    private var backgroundContext = CoreDataStackTest.shared.backgroundContext
    
    override func setUp(){
        super.setUp()
        sut = AlarmLocalDataSource(mainContext: .Main(mainContext), backgroundContext: .Background(mainContext))
        createRequestMock = CreateAlarmRequestor(time: Date(), isEnabled: true)
        fetchRequestMock = FetchAllAlarmRequestor(item: PersistenceService.Entity.AlarmList.FetchRequest)
        expectation = expectation(description: "Alarm local data store expectation")
    }
    func test_fetch_all_alarms(){
        expectation(forNotification: .NSManagedObjectContextDidSave, object: mainContext) { _ in
            return true
        }
        createMockList(completionHandler: {[unowned self] result in
            switch result{
            case .success(_):
                self.sut.fetchList(request: AlarmRequestor.getFetchAllRequest())
                    .sink(receiveCompletion: {completion in
                        if case .failure(let error) = completion,error == .NoDataFound{
                            XCTFail("Alarm data fetch failed")
                            expectation.fulfill()
                        }
                    }, receiveValue: {data in
                        XCTAssert(data.count>0, "No Alarm List found")
                        expectation.fulfill()
                    })
                    .store(in: &cancellable)
            case .failure(_):
                XCTFail("Alarm Data creation failed")
                expectation.fulfill()
            }
        })
        self.waitForExpectations(timeout: 3.0){ error in
            XCTAssertNil(error, "Save did not occur")
        }
    }
    func createMockList(completionHandler: @escaping  (Result<Alarm?,PersistenceFailure>)->Void){
        sut.create(request: createRequestMock)
            .sink(receiveCompletion: {completion in
                if case .failure(let error) = completion,error == .FailedToSave{
                    XCTFail("Alarm Data creation failed")
                    completionHandler(.failure(error))
                }
            }, receiveValue: {data in
                completionHandler(.success(data))
            })
            .store(in: &cancellable)
    }
    override func tearDown(){
        super.tearDown()
        sut = nil
        expectation = nil
        createRequestMock = nil
        fetchRequestMock = nil
    }
    override class func tearDown() {
        super.tearDown()
        CoreDataStackTest.shared.persistentContainer.destroyPersistentStore()
    }
}
