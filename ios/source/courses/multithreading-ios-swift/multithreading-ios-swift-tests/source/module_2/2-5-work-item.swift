// 2-5-work-item

import Foundation

// Абстракция над выполняемой задачей

class DispatchWorkItemTest_1 {
    private let queue = DispatchQueue(
        label: "com.concurrentQueue_1",
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
        return Thread.current.description
    }
}

let dispatchWorkItemTest_1 = DispatchWorkItemTest_1()
dispatchWorkItemTest_1.testNotify()

// Cancel task example
// Отменить задачу можно только до того как она будет поставлена на выполнение.
// Если задача будет поставлена на выполнение, отменить ее не получится.

class DispatchWorkItemTest_2 {
    private let queue = DispatchQueue(
        label: "com.concurrentQueue_2"
    )

    func testCancel() {
        print("\(#function) start")

        queue.async {
            sleep(1)
            print("test1")
        }
        queue.async {
            sleep(1)
            print("test2")
        }

        let item =  DispatchWorkItem {
            print("DispatchWorkItem process")
        }
        queue.async(execute: item)

        item.cancel()

        print("\(#function) end")
    }
}

let dispatchWorkItemTest_2 = DispatchWorkItemTest_2()
dispatchWorkItemTest_2.testCancel()
