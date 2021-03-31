//
//  EventDataSource.swift
//  FetchRewards
//
//  Created by Thomas Woodfin on 03/27/2021.
//  Copyright © 2021 Thomas.Woodfin. All rights reserved.
//

import Foundation

typealias EventDataSourceCompletion = (Result<[Event], Error>) -> Void

protocol EventDataSource {
    
    func queryEvents(query: String, completion: EventDataSourceCompletion?)
    
    func addFavorite(event: Event)
    func removeFavorite(event: Event)
    func isFavorite(event: Event) -> Bool
}
