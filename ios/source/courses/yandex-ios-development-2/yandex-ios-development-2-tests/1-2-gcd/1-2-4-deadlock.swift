import Foundation
import XCTest
import Dispatch

class DeadLockTest: XCTestCase {
    func test() {
        print("\(#function) in \(self) start")

        let group = DispatchGroup()
        let mainQueue = DispatchQueue.main

        group.enter()
        mainQueue.async {
            print("async")

            mainQueue.sync {
                // deadlock
                print("sync")
                group.leave()
            }
        }

        group.wait()
        print("\(#function) in \(self) end")
    }
}
