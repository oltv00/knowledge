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
