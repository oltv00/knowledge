import XCTest
import Foundation
import Dispatch

class BarrierTest: XCTestCase {

    private let group = DispatchGroup()

    func test() {
        print("\(#function) in \(self) start")

        let queue = DispatchQueue(
            label: "com.concurrentQueue",
            qos: .utility,
            attributes: .concurrent
        )

        group.enter()
        queue.async {
            print("Thread start: \(Thread.current.description)")
            (0..<1_000_000).forEach { _ in }
            print("Thread end: \(Thread.current.description)")
            self.group.leave()
        }

        group.enter()
        queue.async {
            print("Thread start: \(Thread.current.description)")
            (0..<1_000_000).forEach { _ in }
            print("Thread end: \(Thread.current.description)")
            self.group.leave()
        }

        group.enter()
        queue.async {
            print("Thread start: \(Thread.current.description)")
            (0..<1_000_000).forEach { _ in }
            print("Thread end: \(Thread.current.description)")
            self.group.leave()
        }

        group.enter()
        queue.async(flags: .barrier) {
            print("async(flags: .barrier) Thread start: \(Thread.current.description)")
            (0..<1_000_000).forEach { _ in }
            print("async(flags: .barrier) Thread end: \(Thread.current.description)")
            self.group.leave()
        }

        group.wait()
        print("\(#function) in \(self) end")
    }
}
