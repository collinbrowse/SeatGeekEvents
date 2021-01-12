//
//  EventCell.swift
//  FetchRewardsCodingExercise
//
//  Created by Collin Browse on 1/6/21.
//

import UIKit

protocol EventFavoritedDelegate: class {
    func didTapFavorite(_ event: Event, completed: @escaping(Bool) -> Void)
}

class EventCell: UITableViewCell {

    static let reuseID = String(describing: EventCell.self)
    
    var eventImageView = FetchEventImageView(frame: .zero)
    var eventNameLabel = UILabel()
    var locationLabel = UILabel()
    var dateLabel = UILabel()
    var favoriteButton = FavoriteButton(isSelected: false)
    
    var event: Event?
    var eventFavoritedDelegate: EventFavoritedDelegate?
    var indexPath: IndexPath = IndexPath()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureLabels()
        configureFavoriteButton()
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func setCellData(event: Event) {
        self.event = event
        
        eventNameLabel.text = event.name
        locationLabel.text = event.venue.location
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = dateFormatter.date(from: event.date) {
            // The Seat Geek API gives a placeholder time if the time is tbd (instead of not giving a time at all)
            if event.timeTBD {
                dateLabel.text = date.getFormattedDate(format: "EEEE, MMM d, yyyy ") + "(Time TBD)"
            } else {
                dateLabel.text = date.getFormattedDate(format: "EEEE, MMM d, yyyy h:mm a")
            }
        }
        
        if let imageURL = event.performers.first?.imageURL {
            eventImageView.downloadImage(fromURL: imageURL)
        }
        
        if event.isFavorite != nil && event.isFavorite! {
            favoriteButton.isSelected = true
        } else {
            favoriteButton.isSelected = false
        }
    }
    
    
    private func configureLabels() {
        eventNameLabel.font = UIFont.systemFont(ofSize: 17)
        locationLabel.font = UIFont.systemFont(ofSize: 15)
        dateLabel.font = UIFont.systemFont(ofSize: 15)
        
        eventNameLabel.textColor = .label
        locationLabel.textColor = .secondaryLabel
        dateLabel.textColor = .secondaryLabel
        
        eventNameLabel.numberOfLines = 0
        dateLabel.numberOfLines = 0
        
        eventNameLabel.sizeToFit()
        locationLabel.sizeToFit()
        dateLabel.sizeToFit()
        
        eventNameLabel.lineBreakMode = .byWordWrapping
        locationLabel.lineBreakMode = .byTruncatingTail
        dateLabel.lineBreakMode = .byWordWrapping
    }
    
    
    func configureFavoriteButton() {
        favoriteButton.addTarget(self, action: #selector(didFavorite), for: .touchUpInside)
    }
    
    
    @objc func didFavorite() {
        
        if event != nil {
            eventFavoritedDelegate?.didTapFavorite(event!, completed: { (isSelected) in
                self.favoriteButton.isSelected = isSelected
                self.event?.isFavorite = isSelected
            })
        }
    }
    
    
    func configure() {
        contentView.addSubviews(eventImageView, eventNameLabel, locationLabel, dateLabel, favoriteButton)
        contentView.addSubview(eventImageView)
        contentView.addSubview(eventNameLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(favoriteButton)
        
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        eventNameLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
    
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100 + padding * 2),   // Set a min height for the cell
            
            eventImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            eventImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            eventImageView.heightAnchor.constraint(equalToConstant: 100),
            eventImageView.widthAnchor.constraint(equalToConstant: 100),
            
            favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            favoriteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            favoriteButton.widthAnchor.constraint(equalToConstant: 28),
            
            eventNameLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: padding),
            eventNameLabel.topAnchor.constraint(equalTo: eventImageView.topAnchor),
            eventNameLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -padding),
            
            locationLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: padding),
            locationLabel.topAnchor.constraint(equalTo: eventNameLabel.bottomAnchor, constant: padding),
            locationLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -padding),
            
            dateLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: padding),
            dateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: padding / 2),
            dateLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -padding),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding * 2)    // Add some extra padding to the bottom
        ])
    }
    
}
