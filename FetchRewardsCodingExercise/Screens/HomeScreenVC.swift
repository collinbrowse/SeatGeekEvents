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
        eventsTableView.eventTableViewDelegate = self
        configureNavController()
        layoutUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func configureNavController() {
        title = ""
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


extension HomeScreenViewController: EventTableViewDelegate {
    
    func didTapEvent(for event: Event) {
        let destVC = EventViewController()
        destVC.setEventData(event: event)
        navigationController?.pushViewController(destVC, animated: true)
    }
    
}
