//
//  EventRepository.swift
//  FetchRewards
//
//  Created by Thomas Woodfin on 03/27/2021.
//  Copyright © 2021 Thomas.Woodfin. All rights reserved.
//

import Foundation

typealias EventRepositoryCompletion = (Result<[Event], Error>) -> Void

class EventRepository {
    
    var networkDataSource: EventDataSource
    var localDataSource: EventDataSource
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        
        networkDataSource = EventNetworkDataSource(networkManager: networkManager)
        localDataSource = EventLocalDataSource()
    }
    
    func queryEvents(query: String, completion: EventRepositoryCompletion?) {
        networkDataSource.queryEvents(query: query) { result in
            switch result {
            case .success(let items):
                completion?(.success(items))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
    func addFavorite(event: Event) {
        localDataSource.addFavorite(event: event)
    }
    
    func removeFavorite(event: Event) {
        localDataSource.removeFavorite(event: event)
    }
    
    func isFavorite(event: Event) -> Bool {
        return localDataSource.isFavorite(event: event)
    }
}
