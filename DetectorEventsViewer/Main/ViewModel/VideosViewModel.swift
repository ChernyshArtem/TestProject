//
//  VideosViewModel.swift
//  DetectorEventsViewer
//
//  Created by Артём Черныш on 14.12.23.
//

import Foundation

protocol VideosViewModelInterface {
    var model: VideosModel { get }
    
    func sortByName()
    
    func sortById() 
    
    func sortByStandart()
    
    func filterByText(filteredText: String)
}

class VideosViewModel: VideosViewModelInterface {
    
    private let apiWorker = APIWorker()
    let model: VideosModel = VideosModel()
    
    init () {
        loadVideosFromAPI(filteredText: nil)
    }
    
    func sortByName() {
        var actualType: ActualSortType = .standartSort
        switch model.actualSortType {
        case .sortByNameIncrease:
            actualType = .sortByNameDecrease
        default:
            actualType = .sortByNameIncrease
        }
        model.actualSortType = actualType
        loadVideosFromAPI(filteredText: nil)
    }
    
    func sortById() {
        var actualType: ActualSortType = .standartSort
        switch model.actualSortType {
        case .sortByIdIncrease:
            actualType = .sortByIdDecrease
        default:
            actualType = .sortByIdIncrease
        }
        model.actualSortType = actualType
        loadVideosFromAPI(filteredText: nil)
    }
    
    func sortByStandart() {
        model.actualSortType = .standartSort
        loadVideosFromAPI(filteredText: nil)
    }
    
    func filterByText(filteredText: String) {
        model.actualSortType = .filterByText
        loadVideosFromAPI(filteredText: filteredText)
    }
    
    private func loadVideosFromAPI(filteredText: String?) {
        apiWorker.loadVideos { [weak self] actualVideos in
            var sortedActualVideos: [Camera] = actualVideos
            switch self?.model.actualSortType {
            case .sortByNameIncrease:
                sortedActualVideos.sort { firstCamera, secondCamera in
                    firstCamera.displayName > secondCamera.displayName
                }
            case .sortByNameDecrease:
                sortedActualVideos.sort { firstCamera, secondCamera in
                    firstCamera.displayName < secondCamera.displayName
                }
            case .sortByIdIncrease:
                sortedActualVideos.sort { firstCamera, secondCamera in
                    firstCamera.displayId > secondCamera.displayId
                }
            case .sortByIdDecrease:
                sortedActualVideos.sort { firstCamera, secondCamera in
                    firstCamera.displayId < secondCamera.displayId
                }
            case .filterByText:
                sortedActualVideos = sortedActualVideos.filter {
                    $0.displayName.contains(filteredText ?? "")
                }
            default:
                break
            }
            self?.model.videos.accept(sortedActualVideos)
        }
    }
}
