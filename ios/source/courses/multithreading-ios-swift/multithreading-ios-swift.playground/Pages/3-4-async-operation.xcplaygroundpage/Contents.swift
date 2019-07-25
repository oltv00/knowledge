// 3-4-async-operation

import Foundation

// AsyncOperation example

class AsyncOperation_1: Operation {
    private var finish = false
    private var execute = false

    private let queue = DispatchQueue(label: "com.serialQueue")

    override var isAsynchronous: Bool { return true }
    override var isFinished: Bool { return finish }
    override var isExecuting: Bool { return execute }

    override func start() {
        queue.async {
            self.main()
        }
        execute = true
    }

    override func main() {
        print("\(#function) in \(self)")
        finish = true
        execute = false
    }
}

//let operation_1 = AsyncOperation_1()
//operation_1.start()

// KVO + AsyncOperation example

// Для того чтобы операция могла взаимодействовать
// с другими операциями, необходимо поддержать механизм KVO.

class AsyncOperation_2: Operation {
    private var finish = false
    private var execute = false

    private let queue = DispatchQueue(label: "com.serialQueue")

    override var isAsynchronous: Bool { return true }
    override var isFinished: Bool { return finish }
    override var isExecuting: Bool { return execute }

    override func start() {
        willChangeValue(forKey: "isExecuting")
        queue.async {
            self.main()
        }
        execute = true
        didChangeValue(forKey: "isExecuting")
    }

    override func main() {
        print("\(#function) in \(self)")

        willChangeValue(forKey: "isFinished")
        willChangeValue(forKey: "isExecuting")

        finish = true
        execute = false

        didChangeValue(forKey: "isFinished")
        didChangeValue(forKey: "isExecuting")
    }
}

//let operation_2 = AsyncOperation_2()
//operation_2.start()

// Sync vs Async executing test

class SyncVsAsync {

    enum Execute {
        case sync
        case async
    }

    class MyOperation: BlockOperation {
        let id: Int

        init(id: Int, block: @escaping () -> Void) {
            self.id = id
            super.init()
            self.addExecutionBlock(block)
        }

        override func start() {
            print("\(self) start with id: \(id)")
            super.start()
        }
    }

    private let operationQueue = OperationQueue()
    private let execute: Execute

    init(_ execute: Execute) {
        self.execute = execute
    }

    func test() {
        print("\(#function) in \(self) start")

        let block = {
            (0..<1_000_000).forEach { _ in }
        }

        let operations = (0..<50).map {
            id in makeOperation(id: id, block: block)
        }

        switch execute {
        case .sync:
            // sync executing
            operations.forEach { $0.start() }
        case .async:
            // async executing in operation queue
            operations.forEach { operationQueue.addOperation($0) }
        }

        print("\(#function) in \(self) end")
    }

    private func makeOperation(id: Int, block: @escaping () -> Void) -> Operation {
        return MyOperation(id: id, block: block)
    }
}

let syncVsAsync = SyncVsAsync(.async)
syncVsAsync.test()
