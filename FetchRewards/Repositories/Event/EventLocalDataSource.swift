//
//  EventLocalDataSource.swift
//  FetchRewards
//
//  Created by Thomas Woodfin on 03/27/2021.
//  Copyright © 2021 Thomas.Woodfin. All rights reserved.
//

import Foundation

class EventLocalDataSource: EventDataSource {
    
    var favoriteCache: Cache<Event>
    
    private let cacheName = "eventsCache"
    private let favoritesSet = "favoritesSet"
    
    init() {
        favoriteCache = Cache(cacheName: cacheName)
    }
    
    func queryEvents(query: String, completion: EventDataSourceCompletion?) {
        completion?(.success([Event]()))
    }
    
    func addFavorite(event: Event) {
        var existingFavorites = favoriteCache.object(key: favoritesSet) ?? Set<Event>()
        existingFavorites.insert(event)
        favoriteCache.setObject(object: existingFavorites, key: favoritesSet)
    }
    
    func removeFavorite(event: Event) {
        var existingFavorites = favoriteCache.object(key: favoritesSet) ?? Set<Event>()
        existingFavorites.remove(event)
        favoriteCache.setObject(object: existingFavorites, key: favoritesSet)
    }
    
    func isFavorite(event: Event) -> Bool {
        let existingFavorites = favoriteCache.object(key: favoritesSet)
        return existingFavorites?.contains(event) ?? false
    }
}
