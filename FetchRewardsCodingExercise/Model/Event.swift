//
//  Event.swift
//  FetchRewardsCodingExercise
//
//  Created by Collin Browse on 1/7/21.
//

import UIKit

struct Events: Decodable, Hashable {
    var events: [Event]
    
    private enum CodingKeys: String, CodingKey {
        case events
    }
}

struct Event: Decodable, Hashable {
    
    var imageURL: String
    var name: String
    var location: String
    var date: String
    var timeTBD: Bool 
    var id: Int
    var venue: Venue
    
    private enum CodingKeys: String, CodingKey {
        case imageURL = "url" //performs/image
        case name = "title"
        case location =  "short_title" //venue/display_location
        case date = "datetime_local"
        case timeTBD = "time_tbd"
        case id
        case venue
    }
}


struct Venue: Decodable, Hashable {
    
    var location: String
    
    private enum CodingKeys: String, CodingKey {
        case location = "display_location"
    }
}
