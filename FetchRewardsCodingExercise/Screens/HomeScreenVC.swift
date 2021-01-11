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
        
        configureTableView()
        configureNavController()
        configureSearchController()
        layoutUI()
    }
    
    
    private func configureTableView() {
        eventsTableView.eventTableViewDelegate = self
        eventsTableView.tableFooterView = UIView()
    }
    
    
    private func configureNavController() {
        title = "Events"
    }
    
    
    private func configureSearchController() {
        
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for an event"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.scopeButtonTitles = ["New Events", "Favorites"]
        searchController.searchBar.showsScopeBar = true
        navigationItem.searchController = searchController
    }
    
    
    private func layoutUI() {
        view.backgroundColor = .systemBackground
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


extension HomeScreenViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        eventsTableView.searchDidUpdate(text: searchController.searchBar.text ?? "")
    }
    
}



extension HomeScreenViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        eventsTableView.updateSelectedScope(with: selectedScope)
    }
}

