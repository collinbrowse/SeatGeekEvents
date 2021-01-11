//
//  Event.swift
//  FetchRewardsCodingExercise
//
//  Created by Collin Browse on 1/7/21.
//

import UIKit

struct Events: Codable, Hashable {
    var events: [Event]
    
    private enum CodingKeys: String, CodingKey {
        case events
    }
}

struct Event: Codable {
    
    var name: String
    var date: String
    var timeTBD: Bool 
    var id: Int
    var venue: Venue
    var performers: [Performers]
    var isFavorite: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case name = "title"
        case date = "datetime_local"
        case timeTBD = "time_tbd"
        case id
        case venue
        case performers
        case isFavorite
    }
}


struct Venue: Codable, Hashable {
    
    var location: String
    
    private enum CodingKeys: String, CodingKey {
        case location = "display_location"
    }
}


struct Performers: Codable, Hashable {
    
    var imageURL: String
    
    private enum CodingKeys: String, CodingKey {
        case imageURL = "image"
    }
}



extension Event: Equatable, Hashable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
