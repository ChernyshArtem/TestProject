//
//  VideosModel.swift
//  DetectorEventsViewer
//
//  Created by Артём Черныш on 14.12.23.
//

import Foundation
import RxRelay

class VideosModel {
    
    let videos: BehaviorRelay<[Camera]> = BehaviorRelay(value: [])
    var actualSortType: ActualSortType = .standartSort
    
}
