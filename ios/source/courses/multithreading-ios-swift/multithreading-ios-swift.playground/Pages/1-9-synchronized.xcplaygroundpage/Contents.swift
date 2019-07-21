// 1-9-synchronized

import Foundation

// @synchronized from Objective-C
// Не рекомендуется к использованию, т.к. данная конструкция
// основана на recursive mutex, лучше использовать recursive mutex на прямую.

class SynchronizedTest {
    private let lock = NSObject()

    func test() {
        objc_sync_enter(lock)
        print("\(#function) \(self)")
        objc_sync_exit(lock)
    }
}

let synchronizedTest = SynchronizedTest()
synchronizedTest.test()
