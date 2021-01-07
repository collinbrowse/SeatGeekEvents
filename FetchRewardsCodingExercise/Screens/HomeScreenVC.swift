//
//  HomeScreenVC.swift
//  FetchRewardsCodingExercise
//
//  Created by Collin Browse on 1/6/21.
//

import UIKit


class HomeScreenViewController: UIViewController {
    
    var eventsTableView = EventsTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureNavController()
        layoutUI()
    }
    
    
    
    private func configureNavController() {
        navigationController?.title = "This is a Title"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func layoutUI() {
        view.addSubview(eventsTableView)
        
        NSLayoutConstraint.activate([
            eventsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            eventsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            eventsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            eventsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
