//
//  EventSearchPresenter.swift
//  FetchRewards
//
//  Created by Thomas Woodfin on 03/27/2021.
//  Copyright © 2021 Thomas.Woodfin. All rights reserved.
//

import Foundation

protocol EventSearchViewModelDelegate: NSObject {
    
    func setState(state: State)
    func setEvents(events: [Event])
    func showMessage(title: String?, message: String?)
}

class EventSearchViewModel {
    
    private let appConfiguration: AppConfiguration
    private var throttleTimer: Timer?
    private var previousQuery: String?

    public weak var delegate: EventSearchViewModelDelegate?
    
    init(appConfiguration: AppConfiguration) {
        self.appConfiguration = appConfiguration
    }
    
    func queryEvents(query: String?) {
        guard let query = query, !query.isEmpty else {
            previousQuery = nil
            throttleTimer?.invalidate()
            self.delegate?.setEvents(events: [])
            self.delegate?.setState(state: .start)
            return
        }
        guard query != previousQuery else {
            return
        }
        previousQuery = query
        self.delegate?.setState(state: .loading)
        
        throttleTimer?.invalidate()
        throttleTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            self?.appConfiguration.eventRepository.queryEvents(query: query) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let events):
                        self?.delegate?.setState(state: events.isEmpty ? .empty : .events)
                        self?.delegate?.setEvents(events: events)
                    case .failure(let error):
                        self?.delegate?.setState(state: .empty)
                        self?.delegate?.showMessage(title: NSLocalizedString("Event Error", comment: ""), message: error.localizedDescription)
                    }
                }
            }
        }
    }
}
