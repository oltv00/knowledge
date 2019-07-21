// 2-6-semaphore

import Foundation

// Semaphore - используется для определения порядка выполнения задач

class SemaphoreTest_1 {
    // value - регулирует колличество потоков которое
    // одновременно может обращаться к ресурсу без отправки signal
    private let semaphore = DispatchSemaphore(value: 0)

    func test() {
        print("\(#function) start")

        DispatchQueue.global().async {
            print("""
                Start queue: \(self.getCurrentQueueName()) \
                on thread: \(self.getCurrentThreadName())
                """)

            sleep(3)

            print("Semaphore: send signal")
            self.semaphore.signal()
        }

        print("""
            Semaphore: wait in \
            queue: \(self.getCurrentQueueName()) \
            on thread: \(self.getCurrentThreadName())
            """)
        semaphore.wait()

        print("Semaphore: after wait")
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

let semaphoreTest_1 = SemaphoreTest_1()
semaphoreTest_1.test()

class SemaphoreTest_2 {
    // value - регулирует колличество потоков которое
    // одновременно может обращаться к ресурсу без отправки signal
    private let semaphore = DispatchSemaphore(value: 1)

    private func doWork() {
        print("\(#function) start)")

        print("""
            Semaphore: wait in \
            queue: \(self.getCurrentQueueName()) \
            on thread: \(self.getCurrentThreadName())
            """)
        semaphore.wait()

        print("""
            Start sleep in \
            queue: \(self.getCurrentQueueName()) \
            on thread: \(self.getCurrentThreadName())
            """)
        sleep(3)

        print("""
            Semaphore: send signal \
            queue: \(self.getCurrentQueueName()) \
            on thread: \(self.getCurrentThreadName())
            """)
        semaphore.signal()

        print("\(#function) end)")
    }

    func test() {
        print("\(#function) start)")

        DispatchQueue.global().async {
            print("""
                Start work 1 in \
                queue: \(self.getCurrentQueueName()) \
                on thread: \(self.getCurrentThreadName())
                """)
            self.doWork()
        }
        DispatchQueue.global().async {
            print("""
                Start work 2 in \
                queue: \(self.getCurrentQueueName()) \
                on thread: \(self.getCurrentThreadName())
                """)
            self.doWork()
        }
        DispatchQueue.global().async {
            print("""
                Start work 3 in \
                queue: \(self.getCurrentQueueName()) \
                on thread: \(self.getCurrentThreadName())
                """)
            self.doWork()
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

let semaphoreTest_2 = SemaphoreTest_2()
semaphoreTest_2.test()
