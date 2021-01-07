//
//  EventCell.swift
//  FetchRewardsCodingExercise
//
//  Created by Collin Browse on 1/6/21.
//

import UIKit

class EventCell: UITableViewCell {

    static let reuseID = String(describing: EventCell.self)
    
    var eventImageView = UIImageView()
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
    
    
    
    private func configureLabels() {
        eventNameLabel.font = UIFont.systemFont(ofSize: 17)
        locationLabel.font = UIFont.systemFont(ofSize: 15)
        dateLabel.font = UIFont.systemFont(ofSize: 15)
        
        eventNameLabel.textColor = .label
        locationLabel.textColor = .secondaryLabel
        dateLabel.textColor = .secondaryLabel
        
        eventNameLabel.numberOfLines = 0
        locationLabel.numberOfLines = 0
        dateLabel.numberOfLines = 0
        
        eventNameLabel.lineBreakMode = .byWordWrapping
        locationLabel.lineBreakMode = .byWordWrapping
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
            
            eventImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            eventImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: padding),
            eventImageView.heightAnchor.constraint(equalToConstant: 100),
            eventImageView.widthAnchor.constraint(equalToConstant: 100),
            
            eventNameLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: padding),
            eventNameLabel.topAnchor.constraint(equalTo: eventImageView.topAnchor),
            eventNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            eventNameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            locationLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: padding),
            locationLabel.topAnchor.constraint(equalTo: eventNameLabel.bottomAnchor, constant: padding),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            locationLabel.heightAnchor.constraint(equalToConstant: locationLabel.font.pointSize + 4),
            
            dateLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: padding),
            dateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
}
