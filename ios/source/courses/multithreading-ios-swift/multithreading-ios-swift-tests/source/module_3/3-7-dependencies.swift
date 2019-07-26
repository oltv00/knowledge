// 3-7-dependencies

import Foundation

// operation_1 <- operation_2
// operation_2.addDependency(operation_1)
// operation_2 - начнет свое выполнение только
// тогда когда operation_1 будет выполнена.

// Dependencies example

class BlockIdOperation: BlockOperation {
    let id: String

    init(id: String, block: @escaping () -> Void) {
        self.id = id
        super.init()
        addExecutionBlock(block)
    }

    override func start() {
        print("\(self) start with id: \(id)")
        super.start()
    }
}

class DependenciesTest {
    private let queue = OperationQueue()

    func test() {
        print("\(#function) in \(self) start")

        let block = { (0..<Int.random(in: 1...1_000_000)).forEach { _ in } }

        let mainOperations = (0..<10).map { iterator in
            makeOperation(id: "main_\(String(iterator))", block: block)
        }

        mainOperations.forEach { operation in
            (0..<3).forEach { iterator in
                let dependencyOperation = makeOperation(
                    id: "dependency_\(String(iterator))_for_\(operation.id)",
                    block: block
                )
                operation.addDependency(dependencyOperation)
            }
        }

        mainOperations.forEach { operation in
            operation.dependencies.forEach { dependencyOperation in
                queue.addOperation(dependencyOperation)
            }
            queue.addOperation(operation)
        }

        print("\(#function) in \(self) end")
    }

    private func makeOperation(id: String, block: @escaping () -> Void) -> BlockIdOperation {
        return BlockIdOperation(id: id, block: block)
    }
}

let dependenciesTest = DependenciesTest()
dependenciesTest.test()
