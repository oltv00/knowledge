// 3-5-maxConcurrentOperationCount

import Foundation

class BlockIdOperation: BlockOperation {
    private let id: Int

    init(id: Int, block: @escaping () -> Void) {
        self.id = id
        super.init()
        addExecutionBlock(block)
    }

    override func start() {
        print("\(self) start with id: \(id)")
        super.start()
    }
}

class OperationCountTest {
    private let operationQueue = OperationQueue()

    func test() {
        print("\(#function) is \(self) start")

        // setup operationQueue
        operationQueue.maxConcurrentOperationCount = 1

        let block = { (0..<Int.random(in: 1..<1_000_000)).forEach { _ in } }
        let operations = (0..<50).map { makeOperation(id: $0, block: block) }
        operations.forEach { operationQueue.addOperation($0) }

        print("\(#function) is \(self) end")
    }

    private func makeOperation(id: Int, block: @escaping () -> Void) -> BlockOperation {
        return BlockIdOperation(id: id, block: block)
    }
}

let operationCountTest = OperationCountTest()
operationCountTest.test()
