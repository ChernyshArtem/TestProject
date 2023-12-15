//
//  DetectorEventsViewerTests.swift
//  DetectorEventsViewerTests
//
//  Created by Артём Черныш on 15.12.23.
//

import XCTest
@testable import DetectorEventsViewer

final class VideosViewModelTests: XCTestCase {
    
    var videosViewModel: VideosViewModelInterface!
    
    override func setUpWithError() throws {
        videosViewModel = VideosViewModel()
        
        continueAfterFailure = true
    }

    override func tearDownWithError() throws {
        videosViewModel = nil
    }
    
    func testCheckStantartType() throws {
        XCTAssertEqual(videosViewModel.model.actualSortType, .standartSort, "Проверка на то что в начале тип сортировки стандартный")
    }
    
    func testCheckIdType() throws {
        videosViewModel.sortById()
        XCTAssertEqual(videosViewModel.model.actualSortType, .sortByIdIncrease, "В первую очередь при выборе сортировки будет выбрана сортировка по возрастанию")
        videosViewModel.sortById()
        XCTAssertEqual(videosViewModel.model.actualSortType, .sortByIdDecrease, "Во вторую очередь при выборе сортировки будет выбрана сортировка по убыванию, и при актуальной сортировке на возрастание следующей должна быть выбрана на убывание")
    }

    func testCheckNameType() throws {
        videosViewModel.sortByName()
        XCTAssertEqual(videosViewModel.model.actualSortType, .sortByNameIncrease, "В первую очередь при выборе сортировки будет выбрана сортировка по возрастанию")
        videosViewModel.sortByName()
        XCTAssertEqual(videosViewModel.model.actualSortType, .sortByNameDecrease, "Во вторую очередь при выборе сортировки будет выбрана сортировка по убыванию, и при актуальной сортировке на возрастание следующей должна быть выбрана на убывание")
    }
    
    func testCheckReturnToStandartType() throws {
        videosViewModel.sortByName()
        XCTAssertEqual(videosViewModel.model.actualSortType, .sortByNameIncrease, "В первую очередь при выборе сортировки будет выбрана сортировка по возрастанию")
        videosViewModel.sortByStandart()
        XCTAssertEqual(videosViewModel.model.actualSortType, .standartSort, "Проверка на то что в начале тип сортировки стандартный")
    }
    
    func testPerformanceNameSort() throws {
        measure  {
            videosViewModel.sortByName()
        }
    }
    
    func testPerformanceIdSort() throws {
        measure {
            videosViewModel.sortById()
        }
    }

    func testPerformanceStandartSort() throws {
        measure {
            videosViewModel.sortByStandart()
        }
    }
    
}
