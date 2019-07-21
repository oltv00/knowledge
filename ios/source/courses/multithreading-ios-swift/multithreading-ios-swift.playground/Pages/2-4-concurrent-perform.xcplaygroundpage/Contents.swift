// 2-4-concurrent-perform

import Foundation

// Concurrent perform работает эффективнее
// чем вызов `DispatchQueue.async` в цикле `for`

// Позволяет эффективно использовать свободные ресурсы системы
// Эффективен при большом количестве итераций

class ConcurrentPerformTest {

    func test() {
        DispatchQueue.concurrentPerform(iterations: 3) { i in
            print(i)
        }
    }
}

let concurrentPerformTest = ConcurrentPerformTest()
concurrentPerformTest.test()
