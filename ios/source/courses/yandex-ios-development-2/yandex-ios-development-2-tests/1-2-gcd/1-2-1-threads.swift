import XCTest

// let lock = NSLock()
// lock.lock()
// lock.lock() // deadlock

// let lock = NSRecursiveLock()
// lock.lock()
// lock.lock()
// lock.unlock()
// lock.unlock()

// spin lock, реализован в виде OSSpinLock и
// os_unfair_lock), но его использование ограничено.
// Дело в том, что поток который выполняет while
// не блокируется на вызовах isFinished.
// То есть когда этот поток получает квант CPU time,
// он просто молотит в холостую как бешеный эти проверки.

// Блокировка потока на основе мьютекса и подобных примитивах
// работает иначе. Если попытка захватить мьюетекс не удастся -
// система переведет этот поток в неактивный режим и не будет
// давать ему кванты CPU, пока мьютекс не разблокирует тот,
// кто захватил его раньше.

class Threads: XCTestCase {

    func testThreads() {
        print("\(#function) start")
        var counter = 0
        let group = DispatchGroup()

        group.enter()
        let thread_1 = Thread {
            print("thread_1 start")
            (0..<10000).forEach { _ in
                counter += 1
            }
            group.leave()
            print("thread_1 end")
        }

        group.enter()
        let thread_2 = Thread {
            print("thread_2 start")

            (0..<10000).forEach { _ in
                counter += 1
            }
            group.leave()
            print("thread_2 end")
        }

        [thread_1, thread_2].forEach { $0.start() }

        group.wait()
        print("counter = \(counter)")
        print("\(#function) end")
    }
}

class ThreadsSync: XCTestCase {

    func testThreadsSync() {
        print("\(#function) start")
        var counter = 0
        let group = DispatchGroup()
        let lock = NSLock()

        group.enter()
        let thread_1 = Thread {
            print("thread_1 start")
            (0..<10000).forEach { _ in
                lock.lock()
                counter += 1
                lock.unlock()
            }
            group.leave()
            print("thread_1 end")
        }

        group.enter()
        let thread_2 = Thread {
            print("thread_2 start")
            (0..<10000).forEach { _ in
                lock.lock()
                counter += 1
                lock.unlock()
            }
            group.leave()
            print("thread_2 end")
        }

        [thread_1, thread_2].forEach { $0.start() }

        group.wait()
        print("counter = \(counter)")
        print("\(#function) end")
    }
}
