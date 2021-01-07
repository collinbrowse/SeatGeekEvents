//
//  HomeScreenVC.swift
//  FetchRewardsCodingExercise
//
//  Created by Collin Browse on 1/6/21.
//

import UIKit

class EventsTableView: UITableView {
    
    enum Section { case main }
    var diffableDataSource: UITableViewDiffableDataSource<Section, String>!
    var events: [String] = []

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .plain)
        
        events.append("Hi")
        events.append("Hi1")
        events.append("Hi2")
        events.append("Hi3")
        configureTableView()
        updateData(for: events)
        configureDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            cell.eventNameLabel.text = "Los Angeles Rams at Tampa Bay Buccaneers"
            cell.locationLabel.text = "Tampa, FL"
            cell.dateLabel.text = "Tuesday, 24 Nov 2020 7:15 PM"
            return cell
        })
    }
    
    
    func updateData(for events: [String]) {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
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


