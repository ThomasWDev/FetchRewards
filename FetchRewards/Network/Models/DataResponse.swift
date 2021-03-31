//
//  DataResponse.swift
//  FetchRewards
//
//  Created by Thomas Woodfin on 6/20/19.
//  Copyright © 2021 Thomas.Woodfin. All rights reserved.
//

import Foundation

struct DataResponse<T> {
    
    let data: T?
    let urlResponse: URLResponse?
    
    init(data: T?, urlResponse: URLResponse?) {
        self.data = data
        self.urlResponse = urlResponse
    }
}
