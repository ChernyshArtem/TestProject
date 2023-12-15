//
//  Event.swift
//  DetectorEventsViewer
//
//  Created by Артём Черныш on 14.12.23.
//

import Foundation

struct Event: Codable {
    let duration : String?
    let id       : String
    let timestamp: String
    let type     : String
}
