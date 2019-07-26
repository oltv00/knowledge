// 1-2-basics

import Foundation
import XCTest

class Basics: XCTestCase {

    func test() {
        // pthread

        var thread = pthread_t(bitPattern: 0)
        var attr = pthread_attr_t()

        pthread_attr_init(&attr)
        pthread_create(&thread, &attr, { pointer in
            print("pthread test")

            return nil
        }, nil)

        // Thread

        var nsthread = Thread {
            print("nsthread test")
        }
        nsthread.start()
    }
}
