// 3-9-completion-block

import Foundation

// completionBlock - вызывается даже в случае если операцию отменить

class CompletionBlockTest {
    private let queue = OperationQueue()

    func test() {
        let operation = BlockOperation {
            print("operation start")
        }
        operation.completionBlock = {
            print("operation finish")
        }
        queue.addOperation(operation)
    }
}

let completionBlockTest = CompletionBlockTest()
completionBlockTest.test()
