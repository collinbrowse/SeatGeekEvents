//
//  HomeScreenVC.swift
//  FetchRewardsCodingExercise
//
//  Created by Collin Browse on 1/6/21.
//

import UIKit

class EventsTableView: UITableView {
    
    enum Section { case main }
    var diffableDataSource: UITableViewDiffableDataSource<Section, Event>!
    var events: [Event] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .plain)
        
        // TODO: Show loading screen
        
        configureTableView()
        configureDataSource()
        loadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func loadData() {
        NetworkManager.shared.getEvents { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let events):
                self.updateData(for: events)
            }
        }
    }
    
    
    private func configureTableView() {
        delegate = self
        backgroundColor = .systemBackground
        rowHeight = 175
        estimatedRowHeight = 175
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        register(EventCell.self, forCellReuseIdentifier: EventCell.reuseID)
    }
    
    
    private func configureDataSource() {
        
        diffableDataSource = UITableViewDiffableDataSource(tableView: self, cellProvider: { (tableView, indexPath, event) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.reuseID, for: indexPath) as! EventCell
            cell.setCellData(event: event)
            return cell
        })
    }
    
    
    func updateData(for events: [Event]) {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Event>()
        snapshot.appendSections([.main])
        snapshot.appendItems(events)
        DispatchQueue.main.async {
            self.diffableDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        }
        self.events = events
    }
    
    
}


extension EventsTableView: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row")
    }
}


