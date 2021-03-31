//
//  EventDetailPresenter.swift
//  FetchRewards
//
//  Created by Thomas Woodfin on 03/27/2021.
//  Copyright © 2021 Thomas.Woodfin. All rights reserved.
//

import Foundation

protocol EventDetailViewModelDelegate: NSObject {
    
    func showEmptyButtonImage()
    func showFilledButtonImage()
}

class EventDetailViewModel {
    
    private let appConfiguration: AppConfiguration
    public weak var delegate: EventDetailViewModelDelegate?
    
    init(appConfiguration: AppConfiguration) {
        self.appConfiguration = appConfiguration
    }
    
    func configureButtonImage(event: Event) {
        if appConfiguration.eventRepository.isFavorite(event: event) {
            delegate?.showFilledButtonImage()
        } else {
            delegate?.showEmptyButtonImage()
        }
    }
    
    func rightBarButtonPressed(event: Event) {
        if appConfiguration.eventRepository.isFavorite(event: event) {
            appConfiguration.eventRepository.removeFavorite(event: event)
        } else {
            appConfiguration.eventRepository.addFavorite(event: event)
        }
        configureButtonImage(event: event)
    }
}
