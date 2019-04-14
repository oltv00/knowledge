//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var foo: (Double) -> Double

foo = sqrt
foo(81)

foo = cos
foo(.pi)

func changeSign(operand: Double) -> Double {
    return -operand
}

foo = changeSign
foo(81)

func bar(closure: (Double) -> Double) {
    closure(81)
}

bar {
    $0
    return 0
}

class A {
    typealias closure = (Double) -> Double

    func foo(bar: closure) {
        bar(81)
    }

    func baz() {
        foo {
            $0
            return 0
        }
    }
}

A().baz()
