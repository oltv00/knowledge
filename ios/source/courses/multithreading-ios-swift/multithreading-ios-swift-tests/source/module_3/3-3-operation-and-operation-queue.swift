// 3-3-operation-and-operation-queue

import Foundation

// OperationQueue - FIFO queue.

class OperationTest_1 {
    private let operationQueue = OperationQueue()

    func test() {
        operationQueue.addOperation {
            print("operationQueue.addOperation")
        }
    }
}

let operationTest_1 = OperationTest_1()
operationTest_1.test()

class OperationTest_2 {

    class OperationA: Operation {
        override func main() {
            print("\(#function) in \(self)")
        }
    }

    private let operationQueue = OperationQueue()

    func test() {
        let operation = OperationA()
        operationQueue.addOperation(operation)
    }
}

let operationTest_2 = OperationTest_2()
operationTest_2.test()
