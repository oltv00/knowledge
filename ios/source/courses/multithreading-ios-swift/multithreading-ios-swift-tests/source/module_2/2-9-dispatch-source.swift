// 2-9-dispatch-source

import Foundation

// DispatchSource - фундаментальный тип данных,
// который позволят взаимодействовать с системными событиями.

// Данный подход очень удобен когда мы работаем
// с нагруженными очередями а взаимодействие с этими
// очередями происходит с различных потоков.

// DispatchSource types:
// Timer - генерирует периодические нотификации
// Signal - взаимодействует с unix-сигналами
// Descriptor - оповещает о том, что с файлом были произведены различные операции
// Process - позволяет слушать события процесса

// TimerSource example

class DispatchSourceTest_1 {
    private let source = DispatchSource.makeTimerSource()

    func test() {
        source.setEventHandler {
            print("\(self) in \(#function)")
        }
        source.schedule(deadline: .now(), repeating: 5)
        source.activate()
    }
}

let dispatchSourceTest_1 = DispatchSourceTest_1()
dispatchSourceTest_1.test()

// UserDataAddSource example
// Существует реализация с логической операцией `ИЛИ`
// При первом обращении к Data, данные будут сбрасываться в 0

class DispatchSourceTest_2 {
    private let source = DispatchSource
        .makeUserDataAddSource(queue: DispatchQueue.main)

    init() {
        source.setEventHandler {
            print("\(self) in \(#function) with \(self.source.data)")
        }
        source.activate()
    }

    func test() {
        DispatchQueue.global().async {
            self.source.add(data: 10)
        }
    }
}

let dispatchSourceTest_2 = DispatchSourceTest_2()
dispatchSourceTest_2.test()
