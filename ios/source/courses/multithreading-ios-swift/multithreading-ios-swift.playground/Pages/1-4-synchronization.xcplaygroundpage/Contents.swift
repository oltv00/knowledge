// 1-4-synchronization

import Foundation

// mutex - позволяет обращаться к ресурсу только одному потоку за раз
// работает по принципу FIFO

// semaphore - позволяет обращаться к ресурсу в n потоков

// unix examples

// pthread_mutex

class PthreadMutex {
    private var mutex = pthread_mutex_t()

    init() {
        pthread_mutex_init(&mutex, nil)
    }

    func test() {
        pthread_mutex_lock(&mutex)
        print("pthread mutex test")
        pthread_mutex_unlock(&mutex)
    }
}

let pthreadMutex = PthreadMutex()
pthreadMutex.test()

// foundation examples

// NSLock mutex

class NSLockTest {
    private let lock = NSLock()

    func test(_ i: Int) {
        lock.lock()
        print("NSLock mutex test: \(i)")
        lock.unlock()
    }
}

let nsLockTest = NSLockTest()
nsLockTest.test(0)
