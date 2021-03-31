//
//  DateFormatter+Extension.swift
//  FetchRewards
//
//  Created by Thomas Woodfin on 03/27/2021.
//  Copyright © 2021 Thomas.Woodfin. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let eventOriginationFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }()
    
    static let eventFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy hh:mm a"
        return formatter
    }()
}
