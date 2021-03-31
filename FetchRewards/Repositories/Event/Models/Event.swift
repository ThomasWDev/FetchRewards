//
//  Event.swift
//  FetchRewards
//
//  Created by Thomas Woodfin on 03/27/2021.
//  Copyright © 2021 Thomas.Woodfin. All rights reserved.
//

import Foundation

struct Event: Codable & Hashable {
    
    let id: Int
    let title: String
    let date: Date?
    let city: String
    let state: String?
    let imageURL: String?
    
    var formattedCityState: String {
        var cityState = "\(city)"
        if let state = state {
            cityState += ", \(state)"
        }
        return cityState
    }
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
