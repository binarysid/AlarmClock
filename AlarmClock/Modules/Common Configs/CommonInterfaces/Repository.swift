//
//  Repository.swift
//  HugeClock
//
//  Created by Linkon Sid on 27/1/23.
//

import Foundation

protocol RepositoryError:Error{
    var noData:Self{get}
    var noService:Self{get}
}
protocol RepositoryProtocol{
    associatedtype T
    func fetchData(limit:Int)->[T]
}
