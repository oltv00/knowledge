// 1-7-read-write-lock

import Foundation

class ReadWriteLockTest {
    private var lock = pthread_rwlock_t()
    private var attr = pthread_rwlockattr_t()

    private var test = 0

    init() {
        pthread_rwlock_init(&lock, &attr)
    }

    var safeTest: Int {
        get {
            print("pthread_rwlock_rdlock(&lock)")
            pthread_rwlock_rdlock(&lock)

            print("let tmp = test")
            let tmp = test

            print("pthread_rwlock_unlock(&lock)")
            pthread_rwlock_unlock(&lock)
            return tmp
        }
        set {
            print("pthread_rwlock_wrlock(&lock)")
            pthread_rwlock_wrlock(&lock)

            print("test = newValue")
            test = newValue

            print("pthread_rwlock_unlock(&lock)")
            pthread_rwlock_unlock(&lock)
        }
    }
}

let rwlockTest = ReadWriteLockTest()
rwlockTest.safeTest = 1

let queue = DispatchQueue(
    label: "com.read-write-lock.concurrentQueue",
    qos: .userInteractive,
    attributes: .concurrent
)

let threads = (0..<100).map { (i: Int) -> Thread in
    return i % 2 == 0
        ? Thread { let _ = rwlockTest.safeTest }
        : Thread { rwlockTest.safeTest += 1 }
}

threads.forEach { thread in queue.async { thread.start() } }
