// 2-8-dispatch-barrier

import Foundation

// DispatchBarrier - использутеся как аналог pthread_rwlock_t в GCD

// DispatchBarrier - дожидается пока выполнятся все блоки в текущией
// очереди поставленные до барьер блока, далее блокирует очередь
// до того момента пока не выполнится сам, после того как он выполнится,
// начинают выполняться блоки поставленные после него.

class DispatchBarrierTest {
    private let queue = DispatchQueue(
        label: "com.concurrentQueue",
        attributes: .concurrent
    )

    private var internalTest = 0

    // Ресурс блокируется на запись.
    func setTest(_ test: Int) {
        queue.async(flags: .barrier) {
            self.internalTest = test
        }
    }

    // Ресурс не блокируется на получение.
    func getTest() -> Int {
        var tmp = 0
        queue.sync {
            tmp = self.internalTest
        }
        return tmp
    }
}

private let queue = DispatchQueue(
    label: "com.concurrentTestQueue",
    attributes: .concurrent
)

let dispatchBarrierTest = DispatchBarrierTest()
dispatchBarrierTest.setTest(1)
dispatchBarrierTest.getTest()
