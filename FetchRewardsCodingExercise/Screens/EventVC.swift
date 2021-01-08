//
//  EventVC.swift
//  FetchRewardsCodingExercise
//
//  Created by Collin Browse on 1/8/21.
//

import UIKit

class EventViewController: UIViewController {
    
    let eventTitleLabel = UILabel()
    let eventImageView = FetchEventImageView(frame: .zero)
    let eventDateLabel = UILabel()
    let eventLocationLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureTitleLabel()
        configureImageView()
        configureLabels()
        layoutUI()
    }
    
    
    public func setEventData(event: Event) {
        eventTitleLabel.text = event.name
        eventLocationLabel.text = event.venue.location
        if let imageURL = event.performers.first?.imageURL {
            eventImageView.downloadImage(fromURL: imageURL)
        }
        
        /*
         This is repeated code, but for sake of speed and conciseness I didn't factor it out
         */
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = dateFormatter.date(from: event.date) {
            if event.timeTBD {
                eventDateLabel.text = date.getFormattedDate(format: "EEEE, MMM d, yyyy ") + "(Time TBD)"
            } else {
                eventDateLabel.text = date.getFormattedDate(format: "EEEE, MMM d, yyyy h:mm a")
            }
        }
    }
    
    
    private func configureTitleLabel() {
        eventTitleLabel.backgroundColor = .clear
        eventTitleLabel.numberOfLines = 0
        eventTitleLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        eventTitleLabel.textAlignment = .center
        eventTitleLabel.textColor = .label
        eventTitleLabel.adjustsFontSizeToFitWidth = true
        eventTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        eventTitleLabel.sizeToFit()
    }
    
    
    private func configureImageView() {
        eventImageView.sizeToFit()
    }
    
    
    private func configureLabels() {
        eventDateLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        eventLocationLabel.font = UIFont.systemFont(ofSize: 15)
        
        eventDateLabel.textColor = .label
        eventLocationLabel.textColor = .secondaryLabel
        
        eventDateLabel.numberOfLines = 0
        eventLocationLabel.numberOfLines = 0
        
        eventDateLabel.sizeToFit()
        eventLocationLabel.sizeToFit()
        
        eventDateLabel.lineBreakMode = .byWordWrapping
        eventLocationLabel.lineBreakMode = .byWordWrapping
        
        eventDateLabel.translatesAutoresizingMaskIntoConstraints = false
        eventLocationLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func layoutUI() {
        view.addSubviews(eventTitleLabel, eventImageView, eventDateLabel, eventLocationLabel)
        
        let padding: CGFloat = 22
        
        NSLayoutConstraint.activate([
            
            eventTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            eventTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            eventTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            eventImageView.topAnchor.constraint(equalTo: eventTitleLabel.bottomAnchor, constant: padding),
            eventImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            eventImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            eventImageView.heightAnchor.constraint(equalTo: eventImageView.widthAnchor),
            
            eventDateLabel.topAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: padding / 2),
            eventDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            eventDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            eventLocationLabel.topAnchor.constraint(equalTo: eventDateLabel.bottomAnchor, constant: padding / 2),
            eventLocationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            eventLocationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    
    }
}
