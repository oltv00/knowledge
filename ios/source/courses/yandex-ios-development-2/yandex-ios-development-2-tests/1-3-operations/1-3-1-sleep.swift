import Foundation
import XCTest

func wait(for time: TimeInterval) {
    print("Time before wait: \(Date())")

    let group = DispatchGroup()
    group.enter()
    DispatchQueue.global().asyncAfter(deadline: .now() + time) {
        group.leave()
    }

    group.wait()

}

class WaitForTest: XCTestCase {
    func test() {
        yandex_ios_development_2_tests.wait(for: 5)
    }
}
print("Time after wait: \(Date())")