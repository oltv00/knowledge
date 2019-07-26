// 1-11-atomic-operations

import Foundation

// Atomic operations - гарантирую корректный результат
// после выполнения в многопоточной среде без применения
// mutex.

class AtomicOperationsPseudoCodeTest {
    func compareAndSwap(
        old: Int,
        new: Int,
        value: UnsafeMutablePointer<Int>
    ) -> Bool {

        if(value.pointee == old) {
            value.pointee = new
            return true
        }

        return false
    }

    func atomicAdd(
        amount: Int,
        value: UnsafeMutablePointer<Int>
    ) -> Int {

        var success = false
        var new = 0

        while success == false {
            let original = value.pointee
            new = original + amount
            success = compareAndSwap(
                old: original,
                new: new,
                value: value
            )
        }

        return new
    }
}

// Atomic operations usage

class AtomicOperationsTest {

    private var i: Int64 = 0

    func test() {
        OSAtomicCompareAndSwap64Barrier(i, 10, &i)
        OSAtomicAdd64Barrier(20, &i)
        OSAtomicIncrement64Barrier(&i)
    }
}

// Barrier

// Некоторые CPU, могут переупорядочить некоторые вызовы,
// т.о. результирующее значение будет неявным.

// MemoryBarrier - форсит выполнение команд перед ним,
// а зачем выполняет команды после него.

class MemoryBarrierTest {
    class TestClass {
        var t1: Int?
        var t2: Int?
    }
    var testClass: TestClass?

    func test() {
        let thread_1 = Thread {
            print("thread_1 start")
            let tmp = TestClass()
            tmp.t1 = 100
            tmp.t2 = 500
            // OSMemoryBarrier()
            atomic_thread_fence(memory_order_relaxed)
            self.testClass = tmp
            print("thread_1 end")
        }
        thread_1.start()

        let thread_2 = Thread {
            print("thread_2 start")
            while self.testClass == nil { }
            // OSMemoryBarrier()
            atomic_thread_fence(memory_order_relaxed)
            print(self.testClass?.t1)
            print("thread_2 end")
        }
        thread_2.start()
    }
}

let memoryBarrierTest = MemoryBarrierTest()
memoryBarrierTest.test()
