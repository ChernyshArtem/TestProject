//
//  Camera.swift
//  DetectorEventsViewer
//
//  Created by Артём Черныш on 14.12.23.
//

import Foundation

struct Camera: Codable {
    let displayId: String
    let displayName: String
    let ipAddress: String
    let isActivated: Bool
}
