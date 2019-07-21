// 2-5-work-item

import Foundation

// Абстракция над выполняемой задачей

class DispatchWorkItemTest_1 {
    private let queue = DispatchQueue(
        label: "com.concurrentQueue",
        attributes: .concurrent
    )

    func testNotify() {
        let item = DispatchWorkItem {
            print("""
                DispatchWorkItem start
                Queue: \(self.getCurrentQueueName())
                Thread: \(self.getCurrentThreadName())
                DispatchWorkItem end
                """)
        }

        item.notify(queue: DispatchQueue.main) {
            print("""
                Notify start
                Queue: \(self.getCurrentQueueName())
                Thread: \(self.getCurrentThreadName())
                Notify end
                """)
        }
        queue.async(execute: item)
    }

    private func getCurrentQueueName() -> String {
        return String(
            cString: __dispatch_queue_get_label(nil),
            encoding: .utf8
        ) ?? "NOT_KNOWN"
    }

    private func getCurrentThreadName() -> String {
        return Thread.current.name ?? "NOT_KNOWN"
    }
}

let dispatchWorkItemTest_1 = DispatchWorkItemTest_1()
dispatchWorkItemTest_1.testNotify()

// Cancel task example

class DispatchWorkItemTest_2 {
    private let queue = DispatchQueue(
        label: "com.concurrentQueue",
        attributes: .concurrent
    )
}
