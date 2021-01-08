//
//  EventVC.swift
//  FetchRewardsCodingExercise
//
//  Created by Collin Browse on 1/8/21.
//

import UIKit

class EventViewController: UIViewController {
    
    
    let eventImageView = FetchEventImageView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureNavController()
        configureImageView()
        layoutUI()
    }
    
    
    public func setEventData(event: Event) {
        navigationController?.title = event.name
        if let imageURL = event.performers.first?.imageURL {
            //eventImageView.downloadImage(fromURL: imageURL)
        }
        
    }
    
    
    
    private func configureNavController() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func configureImageView() {
        eventImageView.sizeToFit()
        
    }
    
    
    private func layoutUI() {
        view.addSubview(eventImageView)
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            eventImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            eventImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            eventImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            eventImageView.heightAnchor.constraint(equalTo: eventImageView.widthAnchor)
        ])
    
    }
}
