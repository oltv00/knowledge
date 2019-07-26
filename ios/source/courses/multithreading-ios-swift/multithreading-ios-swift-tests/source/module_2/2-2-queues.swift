// 2-2-queues

import Foundation

// serialQueue - выполняет задачи последовательно
// concurrentQueue - выполняет задачи параллельно

class QueueTest1 {
    private let serialQueue = DispatchQueue(
        label: "com.serialQueue"
    )
    private let concurrentQueue = DispatchQueue(
        label: "com.concurrentQueue",
        attributes: .concurrent
    )
}

// globalQueue - глобальная очередь из пулла очередей
// все глобальные очереди являются concurrent

// main - serial global queue

// Все глобальные очереди создаются системой,
// и используются для выполнения системных задач,
// поэтому не рекомендуется загружать эти очереди
// большими задачами.

class QueueTest2 {
    private let globalQueue = DispatchQueue.global()
    private let mainQueue = DispatchQueue.main
}
