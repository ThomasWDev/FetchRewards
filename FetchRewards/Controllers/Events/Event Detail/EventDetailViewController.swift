//
//  EventDetailViewController.swift
//  FetchRewards
//
//  Created by Thomas Woodfin on 03/27/2021.
//  Copyright © 2021 Thomas.Woodfin. All rights reserved.
//

import Kingfisher
import UIKit

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    
    private var rightBarButton: UIBarButtonItem!
    private let appConfiguration: AppConfiguration
    private let eventDetailViewModel: EventDetailViewModel
    private var event: Event
    
    init(appConfiguration: AppConfiguration, event: Event) {
        self.appConfiguration = appConfiguration
        eventDetailViewModel = EventDetailViewModel(appConfiguration: appConfiguration)
        self.event = event
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        eventDetailViewModel.delegate = self
        title = event.title
        extendedLayoutIncludesOpaqueBars = true
        
        rightBarButton = UIBarButtonItem(image: UIImage(named: "heart"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(rightBarButtonPressed(sender:)))
        navigationItem.rightBarButtonItems = [rightBarButton]
        eventDetailViewModel.configureButtonImage(event: event)
        
        eventImageView.layer.cornerRadius = 10
        if let imageString = event.imageURL, let url = URL(string: imageString) {
            eventImageView.kf.setImage(with: url)
        }
        eventLocationLabel.text = event.formattedCityState
        if let date = event.date {
            eventDateLabel.text = DateFormatter.eventFormatter.string(from: date)
        }
    }
    
    @objc
    func rightBarButtonPressed(sender: UIBarButtonItem) {
        eventDetailViewModel.rightBarButtonPressed(event: event)
    }
}

// MARK: - EventDetailView

extension EventDetailViewController: EventDetailViewModelDelegate {
    
    func showEmptyButtonImage() {
        rightBarButton.tintColor = .white
        rightBarButton.image = UIImage(named: "heart")
    }
    
    func showFilledButtonImage() {
        rightBarButton.tintColor = .red
        rightBarButton.image = UIImage(named: "heart.fill")
    }
}
