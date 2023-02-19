//
//  ClockRepository.swift
//  AlarmClock
//
//  Created by Linkon Sid on 27/1/23.
//

import Foundation

final class ClockRepository{
    @Inject
    private var dataSource:ClockDataSource
}

extension ClockRepository:ClockRepositoryProtocol{
    func fetchData(limit:Int) -> ContiguousArray<ClockDTO> {
        let data = dataSource.getData()
        let limitedData = data[0..<limit]
        return ContiguousArray(limitedData.compactMap{
            $0.toDomainObj()
        })
    }
}

