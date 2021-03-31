//
//  AppConfiguration.swift
//  FetchRewards
//
//  Created by Thomas Woodfin on 03/27/2021.
//  Copyright © 2021 Thomas.Woodfin. All rights reserved.
//

import Foundation

class AppConfiguration {
    
    var networkManager: NetworkManager
    var eventRepository: EventRepository
    
    init() {
        networkManager = NetworkManager()
        eventRepository = EventRepository(networkManager: networkManager)
    }
}
