import XCTest
import Dispatch

class DispatchSemaphoreTest: XCTestCase {

    let concurrentQueue = DispatchQueue(
        label: "com.concurrentQueue", 
        attributes: .concurrent
    )

    let semaphore = DispatchSemaphore(value: 1)
    let group = DispatchGroup()

    var counter = 0

    func test() {
        print("\(#function) in \(self) start")

        let threads = 4

        (0..<threads).forEach { _ in
            group.enter()
            concurrentQueue.async {
                (0..<10_000).forEach { _ in
                    self.semaphore.wait()
                    self.counter += 1
                    self.semaphore.signal()
                }
                self.group.leave()
            }
        }

        group.wait()
        print("counter: \(counter)")
        print("\(#function) in \(self) end")
    }
}
