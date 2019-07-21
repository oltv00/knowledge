// 1-8-spin-lock

import Foundation

// OS_SPINLOCK_INIT

// По своей сути он представляет цикл While,
// который постоянно опрашивает освобожден ресурс или нет.

// Такой способ не является энергоэффективным, а так же ресурсо-затратен.

// Использовать OS_SPINLOCK_INIT можно в случае если к ресурсу
// обращается небольшое колл-во потоков на небольшой период времени.

class SpinLockTest {
    private var lock = OS_SPINLOCK_INIT

    func test() {
        OSSpinLockLock(&lock)
        print("\(#function) \(self)")
        OSSpinLockUnlock(&lock)
    }
}

let spinLockTest = SpinLockTest()
spinLockTest.test()

// Unfair lock

// В отличии от обычного mutex, который работает по принципу FIFO,
// unfair mutex отдает предпочтение тому потоку,
// который обращается к нему большее колличество раз,
// тем самым сокращает `context switch`

class UnfairLockTest {
    private var lock = os_unfair_lock_s()

    func test() {
        os_unfair_lock_lock(&lock)
        print("\(#function) \(self)")
        os_unfair_lock_unlock(&lock)
    }
}

let unfairLockTest = UnfairLockTest()
unfairLockTest.test()
