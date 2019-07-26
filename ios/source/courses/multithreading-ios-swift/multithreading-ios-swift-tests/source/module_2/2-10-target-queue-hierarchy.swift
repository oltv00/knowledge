// 2-10-target-queue-hierarchy

import Foundation

// Подобный подход сокращает колличество переключений контекста (context switch)
// что позволяет оптимизировать работу приложения.

// Ключевая особенность заключается в том, что `targetQueue` должна быть `serial`,
// т.к. concurrent queue может выполнять свои задачи на нескольких потоках
// т.е. context switch не избежать

class TargetQueueHierarchyTest_1 {
    private let targetQueue = DispatchQueue(label: "com.targetQueue")

    func test() {
        // Передавая `targetQueue` как параметр в `target`, все задачи которые
        // будут попадать в queue_1 будут выполняться на targetQueue
        let queue_1 = DispatchQueue(label: "com.queue_1", target: targetQueue)
        let dispatchSource_1 = DispatchSource.makeTimerSource(queue: queue_1)
        dispatchSource_1.setEventHandler {
            print("dispatchSource_1 event handler")
        }
        dispatchSource_1.schedule(deadline: .now(), repeating: 1)
        dispatchSource_1.activate()

        let queue_2 = DispatchQueue(label: "com.queue_2", target: targetQueue)
        let dispatchSource_2 = DispatchSource.makeTimerSource(queue: queue_2)
        dispatchSource_2.setEventHandler {
            print("dispatchSource_2 event handler")
        }
        dispatchSource_2.schedule(deadline: .now(), repeating: 1)
        dispatchSource_2.activate()
    }
}

let targetQueueHierarchyTest_1 = TargetQueueHierarchyTest_1()
targetQueueHierarchyTest_1.test()
