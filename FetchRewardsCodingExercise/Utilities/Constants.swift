//
//  Constants.swift
//  FetchRewardsCodingExercise
//
//  Created by Collin Browse on 1/7/21.
//

import UIKit


enum NetworkConstants {
    // example request: curl https://api.seatgeek.com/2/events?client_id=MYCLIENTID
    static let seatGeekAPI = "https://api.seatgeek.com/2"
    static let eventsEndpoint = "/events"
    static let clientID = "ODc3MzUwNHwxNjEwMDQxMjI3LjYzNzM0NzI"
    static let secretClientID = "c089ca42865b71477bf6f9833a43bc100ae949037394d72e2645d6f24f704aa5"
}


enum Images {
    
    static let eventPlaceholder = UIImage(named: "empty_stadium")
}
