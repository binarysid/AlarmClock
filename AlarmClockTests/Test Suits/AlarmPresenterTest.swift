//
//  AlarmPresenterTest.swift
//  HugeClockTests
//
//  Created by Linkon Sid on 30/1/23.
//

import XCTest
import Combine
import CoreData

@testable import HugeClock

class AlarmPresenterTest: XCTestCase {
    var sut:AlarmPresenter!
    var dataSource:AlarmLocalDataSource!
    var createRequestMock:[CreateAlarmRequestor]!
    var fetchRequestMock:FetchAllAlarmRequestor!
    var expectation: XCTestExpectation!
    var cancellable = Set<AnyCancellable>()
    var persistenceContainer = CoreDataStackTest.shared.persistentContainer
    private var mainContext:NSManagedObjectContext{
        CoreDataStackTest.shared.mainContext
    }
    private var backgroundContext = CoreDataStackTest.shared.backgroundContext
    
    override func setUp() {
        super.setUp()
        sut = AlarmPresenter(view: MockAlarmViewModel())
        dataSource = AlarmLocalDataSource(mainContext: .Main(mainContext), backgroundContext: .Background(mainContext))
        expectation = expectation(description: "Alarm local data store expectation")
        createRequestMock = [CreateAlarmRequestor(time: Date(), isEnabled: true)]
        fetchRequestMock = FetchAllAlarmRequestor(item: PersistenceService.Entity.AlarmList.FetchRequest)
    }
    override func tearDown() {
        super.tearDown()
        sut = nil
        dataSource = nil
        expectation = nil
        createRequestMock = nil
        fetchRequestMock = nil
    }
    func test_create_viewData(){
        expectation(forNotification: .NSManagedObjectContextDidSave, object: mainContext) { _ in
            return true
        }
        for data in createRequestMock{
            createMockData(data: data)
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+3){[weak self] in
            self?.fetchMockList(completionHandler: { result in
                switch result{
                case .success(let data):
                    do{
                        let viewData = try XCTUnwrap(self?.sut.getViewData(from: data))
                        XCTAssertTrue(viewData.count>0,"No view data found in presenter")
                    }catch{
                        XCTFail("View data unwrapping error")
                    }
                    self?.expectation.fulfill()
                case .failure(_):
                    XCTFail("Unable to fetch data from local source")
                    self?.expectation.fulfill()
                }
            })
        }
        self.waitForExpectations(timeout: 3.0){ error in
            XCTAssertNil(error, "Save did not occur")
        }
    }
    func fetchMockList(completionHandler: @escaping  (Result<[Alarm],PersistenceFailure>)->Void){
        dataSource.fetchList(request: fetchRequestMock)
            .sink(receiveCompletion: {completion in
                if case .failure(let error) = completion,error == .NoDataFound{
                    XCTFail("Alarm data fetch failed")
                    completionHandler(.failure(error))
                }
            }, receiveValue: {data in
                completionHandler(.success(data))
            })
            .store(in: &cancellable)
    }
    func createMockData(data:CreateAlarmRequestor){
        dataSource.create(request: data)
            .sink(receiveCompletion: {completion in
                if case .failure(let error) = completion,error == .FailedToSave{
                    XCTFail("Alarm creation failed")
                }
            }, receiveValue: {data in
                XCTAssertTrue(data.isEnabled, "Disabled after alarm creation.violating default nature")
            })
            .store(in: &cancellable)
    }
    

}
