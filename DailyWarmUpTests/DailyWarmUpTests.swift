
import XCTest
import RealmSwift
@testable import DailyWarmUp

final class DailyWarmUpTests: XCTestCase {

    func testExample() throws {
        let viewModel = ListScreenViewModel()
        let count = viewModel.items.count
        viewModel.save("new item")
        let newCount = viewModel.items.count
        XCTAssertNotEqual(count, newCount)
        
        for item in viewModel.items {
            viewModel.delete(item)
        }
        XCTAssertEqual(viewModel.items.count, 0)
        
        viewModel.save("new item")
        viewModel.update(viewModel.items.first!, "update")
        
        XCTAssertEqual(viewModel.items.first!.name, "update")
    }

    func testPerformanceExample() throws {
        measure {
            
        }
    }

}
