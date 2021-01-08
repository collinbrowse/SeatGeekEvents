//
//  EventCell.swift
//  FetchRewardsCodingExercise
//
//  Created by Collin Browse on 1/6/21.
//

import UIKit

class EventCell: UITableViewCell {

    static let reuseID = String(describing: EventCell.self)
    
    var eventImageView = FetchEventImageView(frame: .zero)
    var eventNameLabel = UILabel()
    var locationLabel = UILabel()
    var dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureLabels()
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func setCellData(event: Event) {
        eventNameLabel.text = event.name
        locationLabel.text = event.venue.location
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = dateFormatter.date(from: event.date) {
            if event.timeTBD {
                dateLabel.text = date.getFormattedDate(format: "EEEE, MMM d, yyyy ") + "(Time TBD)"
            } else {
                dateLabel.text = date.getFormattedDate(format: "EEEE, MMM d, yyyy h:mm a")
            }
        }
        if let imageURL = event.performers.first?.imageURL {
            eventImageView.downloadImage(fromURL: imageURL)
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
    
    
    func configure() {
        
        contentView.addSubview(eventImageView)
        contentView.addSubview(eventNameLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(dateLabel)
        
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
            
            eventNameLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: padding),
            eventNameLabel.topAnchor.constraint(equalTo: eventImageView.topAnchor),
            eventNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            locationLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: padding),
            locationLabel.topAnchor.constraint(equalTo: eventNameLabel.bottomAnchor, constant: padding),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            dateLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: padding),
            dateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: padding / 2),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding * 2)    // Add some extra padding to the bottom
        ])
    }
    
}
