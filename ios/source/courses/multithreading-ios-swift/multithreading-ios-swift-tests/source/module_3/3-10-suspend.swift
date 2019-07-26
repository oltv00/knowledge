// 3-10-suspend

import Foundation

// suspend - возможность остановить выполнение операций в очереди
// остановка происходит не сразу
// запущенная операция в очереди должна быть выполнена

class OperationSuspendTest {
    private let queue = OperationQueue()

    func test() {
        print("\(#function) in \(self) start")

        let operation_1 = BlockOperation {
            print("operation_1 before sleep")
            sleep(1)
            print("operation_1 after sleep")
        }

        let operation_2 = BlockOperation {
            print("operation_2 before sleep")
            sleep(1)
            print("operation_2 after sleep")
        }

        queue.maxConcurrentOperationCount = 1
        queue.addOperation(operation_1)
        queue.addOperation(operation_2)

        print("set isSuspended = true")
        queue.isSuspended = true

        DispatchQueue.global().asyncAfter(deadline: .now() + 3) { [queue] in
            print("set isSuspended = false")
            queue.isSuspended = false
        }

        print("\(#function) in \(self) end")
    }
}

let operationSuspendTest = OperationSuspendTest()
operationSuspendTest.test()
