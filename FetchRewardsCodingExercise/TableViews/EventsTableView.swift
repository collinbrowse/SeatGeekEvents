//
//  HomeScreenVC.swift
//  FetchRewardsCodingExercise
//
//  Created by Collin Browse on 1/6/21.
//

import UIKit

protocol EventTableViewDelegate: class {
    func didTapEvent(for event: Event)
}


class EventsTableView: UITableView {
    
    enum Section { case main }
    var diffableDataSource: UITableViewDiffableDataSource<Section, Event>!
    var eventTableViewDelegate: EventTableViewDelegate?
    var events: [Event] = []
    var favorites: [Event] = []
    var activeList: [Event] = []
    var filteredActiveList: [Event] = []
    var isSearching = false
    var selectedScope = 0
    var searchText = ""
    var containerView: UIView!
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .plain)
                
        configureTableView()
        configureDataSource()
        getEvents()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureTableView() {
        delegate = self
        backgroundColor = .systemBackground
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 175
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        register(EventCell.self, forCellReuseIdentifier: EventCell.reuseID)
    }
    
    
    private func configureDataSource() {
        
        diffableDataSource = UITableViewDiffableDataSource(tableView: self, cellProvider: { (tableView, indexPath, event) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.reuseID, for: indexPath) as! EventCell
            cell.setCellData(event: event)  // Inject dependencies into the cell
            cell.eventFavoritedDelegate = self  // Let the cell communicate that a favorite button was tapped
            return cell
        })
    }
    
    
    private func getEvents() {
        loadData { [weak self] (events)  in
            guard let self = self else { return }
            self.activeList = events
            self.getFavorites()
        }
    }
    
    
    private func getFavorites() {
        
        PersistenceManager.retrieveFavorites { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                self.favorites = favorites
            case .failure(let error):
                print("Something went wrong: \(error.rawValue)")
            }
            
            // Update events from network call if they have already been favorited
            for favorite in self.favorites {
                if let index = self.events.firstIndex(where: { $0.id == favorite.id }) {
                    self.events[index] = favorite
                }
            }
            
            self.updateData(for: self.events)
            self.dismissLoadingView()
        }
    }
    
    
    private func loadData(completed: @escaping ([Event]) -> Void) {
        
        showLoadingView()
        NetworkManager.shared.getEvents { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let events):
                self.events = events
                completed(events)
            }
        }
    }
    
    
    func updateData(for events: [Event]) {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Event>()
        snapshot.appendSections([.main])
        snapshot.appendItems(events)
        DispatchQueue.main.async {
            self.diffableDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        }
    }
    
    
    func searchDidUpdate(text: String) {
        
        searchText = text   // Remember the updated searchText so favoriting an event does not update the UI incorrectly
        if text == "" {
            filteredActiveList.removeAll()
            updateData(for: activeList)
            isSearching = false
            return
        }
        
        isSearching = true
        filteredActiveList = activeList.filter { $0.name.lowercased().contains(text.lowercased()) }
        updateData(for: filteredActiveList)
    }
}


extension EventsTableView: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredActiveList : activeList
        // Let HomeScreenVC perform the UI Navigation to the next screen
        eventTableViewDelegate?.didTapEvent(for: activeArray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension EventsTableView: EventFavoritedDelegate {
    
    func didTapFavorite(_ event: Event, completed: @escaping (Bool) -> Void) {
        
        // Update the Event Object
        var favoriteEvent = event
        var actionType: PersistenceActionType?
        favoriteEvent.isFavorite?.toggle()
        
        switch favoriteEvent.isFavorite {
        case true:
            actionType = .add
        case false:
            actionType = .remove
        default:
            favoriteEvent.isFavorite = true
            actionType = .add
        }
        
        // Update User Defaults
        PersistenceManager.update(with: favoriteEvent, actionType: actionType!) { [weak self] (error) in
            guard let self = self else { return }
            
            if error == nil {

                let eventIndex = self.events.firstIndex(where: { $0.id == favoriteEvent.id })
                let favoritesIndex = self.favorites.firstIndex(where: { $0.id == favoriteEvent.id })
                
                // Update the data source arrays
                if self.selectedScope == 0 && actionType == .remove {
                    self.events[eventIndex!] = favoriteEvent
                    self.favorites.remove(at: favoritesIndex!)
                    self.activeList = self.events
                } else if self.selectedScope == 0 && actionType == .add {
                    self.events[eventIndex!] = favoriteEvent
                    self.favorites.append(favoriteEvent)
                    self.activeList = self.events
                } else if self.selectedScope == 1 && actionType == .remove {
                    self.events[eventIndex!] = favoriteEvent
                    self.favorites.remove(at: favoritesIndex!)
                    self.activeList = self.favorites
                }
                self.searchDidUpdate(text: self.searchText)
            } else {
                print(error!.localizedDescription)
            }
            
            completed(favoriteEvent.isFavorite!)
        }
    }
}


extension EventsTableView {
    
    // Triggered from UISearchBarDelegate
    func updateSelectedScope(with selectedScope: Int) {
        
        if selectedScope == 0 {
            self.selectedScope = 0
            activeList = events
        } else if selectedScope == 1 {
            self.selectedScope = 1
            activeList = favorites
        }
        
        self.updateData(for: activeList)
    }
}


extension EventsTableView {
    
    func showLoadingView() {
        
        containerView = UIView(frame: self.bounds)
        addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
}
