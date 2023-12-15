//
//  CamerasResponse.swift
//  DetectorEventsViewer
//
//  Created by Артём Черныш on 14.12.23.
//

import Foundation

struct CamerasResponse: Codable {
    let actualCameras: [Camera]

    enum CodingKeys: String, CodingKey {
        case actualCameras = "cameras"
    }
}
