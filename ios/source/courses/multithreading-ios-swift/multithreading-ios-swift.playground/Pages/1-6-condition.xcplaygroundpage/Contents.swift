// 1-6-condition

import Foundation

// Condition mutext
// Задача закрытая condition не начнет выполняться
// пока не получит некий сигнал из другого потока.

// unix example

class MutexConditionTest {
    private var condition = pthread_cond_t()
    private var mutex = pthread_mutex_t()
    private var check = false

    init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }

    func test_1() {
        print("\(#function) \(self) start")
        pthread_mutex_lock(&mutex)
        while check == false {
            print("\(#function) \(self) while check")
            pthread_cond_wait(&condition, &mutex)
        }
        // do something
        print("\(#function) \(self) get signal")
        pthread_mutex_unlock(&mutex)
        print("\(#function) \(self) end")
    }

    func test_2() {
        print("\(#function) \(self) start")
        pthread_mutex_lock(&mutex)
        check = true
        pthread_cond_signal(&condition)
        print("\(#function) \(self) send signal")
        pthread_mutex_unlock(&mutex)
        print("\(#function) \(self) end")
    }
}

let mutexConditionTest = MutexConditionTest()

var queue_1 = DispatchQueue(label: "com.condition.serialQueue_1")
let threads_1: [Thread] = [
    .init { mutexConditionTest.test_1() },
    .init { mutexConditionTest.test_2() },
]

threads_1.forEach { thread in queue_1.sync { thread.start() } }

// NSCondition

class FoundationMutexConditionTest {
    private let condition = NSCondition()
    private var check = false

    func test_1() {
        print("\(#function) \(self) start")
        condition.lock()
        while check == false {
            print("\(#function) \(self) while check")
            condition.wait()
        }
        print("\(#function) \(self) get signal")
        condition.unlock()
        print("\(#function) \(self) end")
    }

    func test_2() {
        print("\(#function) \(self) start")
        condition.lock()
        check = true
        condition.signal()
        print("\(#function) \(self) send signal")
        condition.unlock()
        print("\(#function) \(self) end")
    }
}

let foundationMutexConditionTest = FoundationMutexConditionTest()

var queue_2 = DispatchQueue(label: "com.condition.serialQueue_2")
let threads_2: [Thread] = [
    .init { foundationMutexConditionTest.test_1() },
    .init { foundationMutexConditionTest.test_2() },
]

threads_2.forEach { thread in queue_2.sync { thread.start() } }
