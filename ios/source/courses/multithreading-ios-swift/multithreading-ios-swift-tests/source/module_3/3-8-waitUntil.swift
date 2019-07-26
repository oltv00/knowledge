// 3-8-waitUntil

import Foundation

// waitUntil - блокирует вызывающий поток,
// до тех пока все операции не выполнятся.

// waitUntil example 1

class WaitOperationsTest_1 {
    private let queue = OperationQueue()

    func test() {
        print("\(#function) in \(self) start")

        queue.addOperation {
            print("operation_1 before sleep")
            sleep(1)
            print("operation_1 after sleep")
        }
        queue.addOperation {
            print("operation_2 before sleep")
            sleep(2)
            print("operation_2 after sleep")
        }

        queue.waitUntilAllOperationsAreFinished()
        print("\(#function) in \(self) end")
    }
}

let waitOperationsTest_1 = WaitOperationsTest_1()
waitOperationsTest_1.test()

// waitUntil example 2

class WaitOperationsTest_2 {
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
            sleep(2)
            print("operation_2 after sleep")
        }

        let operations = [operation_1, operation_2]
        queue.addOperations(operations, waitUntilFinished: true)
        print("\(#function) in \(self) end")
    }
}

let waitOperationsTest_2 = WaitOperationsTest_2()
waitOperationsTest_2.test()
