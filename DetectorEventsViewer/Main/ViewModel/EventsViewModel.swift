//
//  EventsViewModel.swift
//  DetectorEventsViewer
//
//  Created by Артём Черныш on 14.12.23.
//

import Foundation

protocol EventsViewModelInterface {
    var model: EventsModel { get }
    func loadEventsFromAPI()
}

class EventsViewModel: EventsViewModelInterface {
    
    init() {
        loadEventsFromAPI()
    }
    
    private let apiWorker = APIWorker()
    let model: EventsModel = EventsModel()
    
    func loadEventsFromAPI() {
        apiWorker.loadEvents { [weak self] actualEvents in
            let sortedActualEvents = actualEvents.sorted { firstEvent, secondEvent in
                firstEvent.timestamp > secondEvent.timestamp
            }
            self?.model.events.accept(sortedActualEvents)
        }
    }
    
}
