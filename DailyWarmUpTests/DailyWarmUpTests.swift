//
//  DailyWarmUpTests.swift
//  DailyWarmUpTests
//
//  Created by Workspace on 15/02/23.
//

import XCTest
import RealmSwift
@testable import DailyWarmUp

final class DailyWarmUpTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let vm = ViewModel()
        let count = vm.items.count
        vm.save("100", "100")
        let newCount = vm.items.count
        XCTAssertNotEqual(newCount, count)
        
        for item in vm.items {
            vm.delete(item)
        }
        
        XCTAssertEqual(vm.items.count, 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
