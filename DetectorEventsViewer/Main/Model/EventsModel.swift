//
//  EventsModel.swift
//  DetectorEventsViewer
//
//  Created by Артём Черныш on 14.12.23.
//

import Foundation
import RxRelay

class EventsModel {
    var events: BehaviorRelay<[Event]> = BehaviorRelay(value: [])
}
