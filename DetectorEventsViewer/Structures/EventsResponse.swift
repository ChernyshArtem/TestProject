//
//  EventsResponse.swift
//  DetectorEventsViewer
//
//  Created by Артём Черныш on 14.12.23.
//

import Foundation

struct EventsResponse: Codable {
    let actualEvents: [Event]

    enum CodingKeys: String, CodingKey {
        case actualEvents = "events"
    }
}
