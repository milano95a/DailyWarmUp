
import XCTest
import RealmSwift
@testable import DailyWarmUp

final class DailyWarmUpTests: XCTestCase {

    func testExample() throws {
        let vm = TopicViewModel()
        let oldCount = vm.topics.count
        vm.save("Topic 1")
        let newCount = vm.topics.count
        XCTAssertNotEqual(oldCount, newCount)
        
        for topic in vm.topics {
            vm.delete(topic)
        }
        XCTAssertEqual(vm.topics.count, 0)
        
        vm.save("Topic")
        vm.update(vm.topics.first!, "Topic Updated")
        XCTAssertEqual(vm.topics.first!.name, "Topic Updated")        
    }

    func testPerformanceExample() throws {
        measure {
            
        }
    }
}
