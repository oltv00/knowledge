// 2-7-dispatch-group

import Foundation

// DispatchGroup - используется для определения порядка выполнения задач

// DispatchGroup - позволяет объеденить задачи в группу и затем дожидаться
// пока не выполнятся все задачи входящие в эту группу

// Когда объединенные задачи в группе добавляются в очередь и вызывается
// у группы метод `wait` вызывающий поток блокируется до того момента пока
// все задачи входящие в эту группу будут выполнены

// queue.async(group: group)-notify example

class DispatchGroupTest_1 {
    private let group = DispatchGroup()

    private let queue = DispatchQueue(
        label: "com.concurrentQueue_1",
        attributes: .concurrent
    )

    func testNotify() {
        print("\(#function) start")

        queue.async(group: group) {
            print("""
                Start task \
                queue: \(self.getCurrentQueueName()) \
                on thread: \(self.getCurrentThreadName())
                """)

            sleep(3)

            print("""
                Finish task \
                queue: \(self.getCurrentQueueName()) \
                on thread: \(self.getCurrentThreadName())
                """)
        }
        queue.async(group: group) {
            print("""
                Start task \
                queue: \(self.getCurrentQueueName()) \
                on thread: \(self.getCurrentThreadName())
                """)

            sleep(5)

            print("""
                Finish task \
                queue: \(self.getCurrentQueueName()) \
                on thread: \(self.getCurrentThreadName())
                """)
        }
        group.notify(queue: DispatchQueue.main) {
            print("""
                Finish all tasks \
                queue: \(self.getCurrentQueueName()) \
                on thread: \(self.getCurrentThreadName())
                """)
        }

        print("\(#function) end")
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

let dispatchGroupTest_1 = DispatchGroupTest_1()
dispatchGroupTest_1.testNotify()

// queue.async with group.enter-leave-wait example

class DispatchGroupTest_2 {
    private let group = DispatchGroup()

    private let queue = DispatchQueue(
        label: "com.concurrentQueue_2",
        attributes: .concurrent
    )

    func testWait() {
        print("\(#function) start")

        group.enter()
        queue.async {
            print("""
                Start task \
                queue: \(self.getCurrentQueueName()) \
                on thread: \(self.getCurrentThreadName())
                """)

            sleep(3)

            print("""
                Finish task \
                queue: \(self.getCurrentQueueName()) \
                on thread: \(self.getCurrentThreadName())
                """)

            self.group.leave()
        }

        group.enter()
        queue.async {
            print("""
                Start task \
                queue: \(self.getCurrentQueueName()) \
                on thread: \(self.getCurrentThreadName())
                """)

            sleep(5)

            print("""
                Finish task \
                queue: \(self.getCurrentQueueName()) \
                on thread: \(self.getCurrentThreadName())
                """)

            self.group.leave()
        }

        group.wait()

        print("""
            Finish all tasks \
            queue: \(self.getCurrentQueueName()) \
            on thread: \(self.getCurrentThreadName())
            """)

        print("\(#function) end")
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

let dispatchGroupTest_2 = DispatchGroupTest_2()
dispatchGroupTest_2.testWait()
