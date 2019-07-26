// 3-6-cancel-operation

import Foundation

class CancelTest {

    class OperationCancelTest: Operation {
        override func main() {
            print("\(#function) in \(self) start")

            print("if isCancelled: \(isCancelled)")
            if isCancelled { return }
            sleep(1)

            print("if isCancelled: \(isCancelled)")
            if isCancelled { return }

            print("\(#function) in \(self) end")
        }
    }

    private let queue = OperationQueue()

    func test() {
        print("\(#function) in \(self) start")

        let operation = OperationCancelTest()
        queue.addOperation(operation)

        print("operation: \(operation) cancel called")
        operation.cancel()

        print("\(#function) in \(self) end")
    }
}

let cancelTest = CancelTest()
cancelTest.test()
