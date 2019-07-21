// 1-10-problems

import Foundation

// DeadLock - Потоки пытаются обратиться к уже захваченным ресурсам,
// в следствие чего программа зависает.

// LiveLock - Оба потока выполняют бесполезную работу.

// Priority inversion - Низкоприоритетный поток захватывает ресурс,
// остальные потоки ждут.

/*
 In concurrent computing, a deadlock is a state in which each member of a group of actions, is waiting for some other member to release a lock
 A livelock is similar to a deadlock, except that the states of the processes involved in the livelock constantly change with regard to one another, none progressing. Livelock is a special case of resource starvation; the general definition only states that a specific process is not progressing.
 A real-world example of livelock occurs when two people meet in a narrow corridor, and each tries to be polite by moving aside to let the other pass, but they end up swaying from side to side without making any progress because they both repeatedly move the same way at the same time.
 Livelock is a risk with some algorithms that detect and recover from deadlock. If more than one process takes action, the deadlock detection algorithm can be repeatedly triggered. This can be avoided by ensuring that only one process (chosen randomly or by priority) takes action.
*/

// deadlock example

class DeadLockTest {
    private let lock_1 = NSLock()
    private let lock_2 = NSLock()

    var resource_A = false
    var resource_B = false

    func test_1() {
        print("\(#function) \(self) start")
        lock_1.lock()
        resource_A = true

        lock_2.lock()
        resource_B = true
        lock_2.unlock()

        lock_1.unlock()
        print("\(#function) \(self) end")
    }

    func test_2() {
        print("\(#function) \(self) start")
        lock_2.lock()
        resource_B = true

        lock_1.lock()
        resource_A = true
        lock_1.unlock()

        lock_2.unlock()
        print("\(#function) \(self) end")
    }
}

let deadLockTest = DeadLockTest()

let threads: [Thread] = [
    .init { deadLockTest.test_1() },
    .init { deadLockTest.test_2() },
]

threads.forEach { $0.start() }
