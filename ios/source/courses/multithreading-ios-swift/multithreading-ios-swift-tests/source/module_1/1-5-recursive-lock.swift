// 1-5-recursive-lock

import Foundation
import XCTest

// Recursive pthread_mutex
// Recursive mutex - позволяет потоку множества раз захватывать один и тот же ресурс

// Ядро операционной системы сохраняет след потока, которые уже захватил
// ресурс и позволяет ему захватывать ресурсы закрытые этим mutex.

// Обычно используется в рекурсивных функциях, или в случаях, когда
// несколько функций закрыты рекурсивным mutex и нужно вызвать их друг из друга.

// unix example

class RecursiveMutex {
    private var mutex = pthread_mutex_t()
    private var attr = pthread_mutexattr_t()

    init() {
        pthread_mutexattr_init(&attr)

        // Если не указывать тип аттрибута PTHREAD_MUTEX_RECURSIVE,
        // то при вызове функции `test_2`, поток перешел бы в состояние
        // ожидания до тех пор, пока он же сам не освободит mutex.
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutex_init(&mutex, &attr)
    }

    func test_1() {
        pthread_mutex_lock(&mutex)
        test_2()
        pthread_mutex_unlock(&mutex)
    }

    func test_2() {
        pthread_mutex_lock(&mutex)
        print("\(#function) pthread_mutex_t mutex test")
        pthread_mutex_unlock(&mutex)
    }
}

class RecursiveMutexTest: XCTestCase {
    func test() {
        let recursiveMutexTest = RecursiveMutex()
        recursiveMutexTest.test_1()
    }
}

// NSRecursiveLock

class RecursiveLock {
    private let lock = NSRecursiveLock()

    func test_1() {
        lock.lock()
        test_2()
        lock.unlock()
    }

    func test_2() {
        lock.lock()
        print("\(#function) NSRecursiveLock mutex test")
        lock.unlock()
    }
}

class RecursiveLockTest: XCTestCase {
    func test() {
        let recursiveLockTest = RecursiveLock()
        recursiveLockTest.test_1()
    }
}
