//
//  APIWorkerTests.swift
//  DetectorEventsViewerTests
//
//  Created by Артём Черныш on 15.12.23.
//

import XCTest
@testable import DetectorEventsViewer

final class APIWorkerTests: XCTestCase {

    var apiWoker: APIWorker!
    
    override func setUpWithError() throws {
        apiWoker = APIWorker()
        
        continueAfterFailure = true
    }

    override func tearDownWithError() throws {
        apiWoker = nil
    }

    func testCheckActualLogin() throws {
        apiWoker.checkUserLogin(name: "root", password: "root") { success in
            XCTAssertEqual(success, true, "При вводе корректных даннных должен быть выведен true")
        }
    }
    
    func testCheckFakeLogin() throws {
        apiWoker.checkUserLogin(name: "fakeRoot", password: "fakeRoot") { success in
            XCTAssertEqual(success, false, "При вводе ненастоящих даннных должен быть выведен false")
        }
    }

    func testPerformanceLoadVideos() throws {
        measure {
            apiWoker.loadVideos { _ in
            }
        }
    }
    
    func testPerformanceLoadEvents() throws {
        measure {
            apiWoker.loadEvents { _ in
            }
        }
    }
    
    func testPerformanceCheckLogin() throws {
        measure {
            apiWoker.checkUserLogin(name: "root", password: "root") { _ in
            }
        }
    }

}
