// 2-3-methods

import Foundation

// Async vs Sync

// Async - управление возвращается вызывающему потоку
// Sync - вызывающий поток ожидает выполнение задачи

// SerialQueue example
// test1 -> test2 -> test3 -> test4

class AsyncVsSyncTest1 {
    private let serialQueue = DispatchQueue(label: "com.serialQueue")

    func testSerial() {
        serialQueue.async {
            print("\(#function) test1")
        }

        serialQueue.async {
            print("\(#function) test2")
        }

        serialQueue.sync {
            print("\(#function) test3")
        }

        serialQueue.sync {
            print("\(#function) test4")
        }
    }
}

let asyncVsSyncTest1 = AsyncVsSyncTest1()
asyncVsSyncTest1.testSerial()

// ConcurrentQueue example
// test3 -> test4
// test1 и test2 будут выполняться параллельно

class AsyncVsSyncTest2 {
    private let concurrentQueue = DispatchQueue(
        label: "com.concurrentQueue",
        attributes: .concurrent
    )

    func testConcurrent() {
        concurrentQueue.async {
            print("\(#function) test1")
        }

        concurrentQueue.async {
            print("\(#function) test2")
        }

        concurrentQueue.sync {
            print("\(#function) test3")
        }

        concurrentQueue.sync {
            print("\(#function) test4")
        }
    }
}

let asyncVsSyncTest2 = AsyncVsSyncTest2()
asyncVsSyncTest2.testConcurrent()

// Async after example

class AsyncAfterTest {
    private let concurrentQueue = DispatchQueue(
        label: "com.concurrentQueue",
        attributes: .concurrent
    )

    func test() {
        concurrentQueue.asyncAfter(deadline: .now() + 3) {
            print("\(#function) \(self) test")
        }
    }
}

let asyncAfterTest = AsyncAfterTest()
asyncAfterTest.test()
