//
//  EventSearchCell.swift
//  FetchRewards
//
//  Created by Thomas Woodfin on 03/27/2021.
//  Copyright © 2021 Thomas.Woodfin. All rights reserved.
//

import Kingfisher
import UIKit

class EventSearchCell: UITableViewCell {
    
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var eventImageView: UIImageView!
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureData(event: Event, isFavorite: Bool) {
        favoriteImageView.isHidden = !isFavorite
        eventImageView.layer.cornerRadius = 10
        if let imageString = event.imageURL, let url = URL(string: imageString) {
            eventImageView.kf.setImage(with: url)
        } else {
            eventImageView.image = nil
        }
        eventTitleLabel.text = event.title
        eventLocationLabel.text = event.formattedCityState
        if let date = event.date {
            eventDateLabel.text = DateFormatter.eventFormatter.string(from: date)
        }
    }
}
