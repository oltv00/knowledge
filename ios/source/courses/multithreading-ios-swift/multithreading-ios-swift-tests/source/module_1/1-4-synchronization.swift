// 1-4-synchronization

import Foundation
import XCTest
import Darwin

// mutex - позволяет обращаться к ресурсу только одному потоку за раз
// работает по принципу FIFO

// semaphore - позволяет обращаться к ресурсу в n потоков

// unix examples

// pthread_mutex

class PthreadMutex: XCTestCase {

    private lazy var mutex: pthread_mutex_t = {
        var mutex = pthread_mutex_t()
        pthread_mutex_init(&mutex, nil)
        return mutex
    }()

    func test() {
        pthread_mutex_lock(&mutex)
        print("pthread mutex test")
        pthread_mutex_unlock(&mutex)
    }
}

// foundation examples

// NSLock mutex

class NSLockTest: XCTestCase {

    private let lock = NSLock()

    func test() {
        lock.lock()
        print("NSLock mutex test")
        lock.unlock()
    }
}
