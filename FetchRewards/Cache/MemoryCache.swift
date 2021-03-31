//
//  MemoryCache.swift
//  FetchRewards
//
//  Created by Thomas Woodfin on 03/20/2021.
//  Copyright © 2021 Thomas.Woodfin. All rights reserved.
//

import Foundation

class MemoryCache<T: Codable & Hashable> {
    
    private var cache = [String: [String: Set<T>]]()
    private let queue = DispatchQueue(label: "MemoryCacheQueue", attributes: .concurrent)
    private let cacheName: String
    
    init(cacheName: String) {
        self.cacheName = cacheName
        cache[cacheName] = [String: Set<T>]()
    }
    
    func setObject(object: Set<T>, key: String) {
        queue.async(flags: .barrier) { [weak self] in
            guard let strongSelf = self else {
                return
            }
            self?.cache[strongSelf.cacheName]?[key] = object
        }
    }
    
    func object(key: String) -> Set<T>? {
        var object: Set<T>?
        queue.sync { [weak self] in
            guard let strongSelf = self else {
                return
            }
            object = self?.cache[strongSelf.cacheName]?[key]
        }
        return object
    }
    
    func removeCache() {
        cache[cacheName] = [String: Set<T>]()
    }
}
