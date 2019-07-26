// 3-2-operation

import Foundation

// class Operation - является примером паттерна `Команда`,
// т.е. завернутый в абстракцию некий функционал

// Operation structure
//
// Statuses:
// Ready - перед тем как начать выполнение
// Executing - начинается выполнение операции
// Finished - операция закончена
// -> Pending -> Ready -> Executing -> Finished
// -> Pending -> Cancelled
// -> Ready -> Cancelled
// -> Executing -> Cancelled
//
// Methods, properties:

// isReady говорит о том, что операция готова для выполнения
// (свойство выставлено в true). Свойство выставлено в false,
// если зависимые операции еще не выполнились. Обычно у вас нет
// прямой необходимости для того, чтобы переопределять это свойство.
// Если готовность ваших операций определяется не только через зависимые
// операции, вы можете предоставить свою собственную имплементацию isReady
// и определять готовность операции для выполнения самостоятельно.
//
// isAsynchronous - является ли операция асинхронной
// (по умолчанию создается синхронная операция)
//
// isExecuting означает, что операция выполняется в данный момент.
// True если операция выполняется, false если нет. Если вы переопределяете
// метод start, вы также должны переопределить isExecuting и отправлять
// kvo нотификации, когда статус выполнения вашей операции изменился.
//
// isFinished означает, что операция была успешно завершена или отменена.
// Пока свойство будет выставлено в false, операция будет находиться в
// operation queue. Если вы переопределяете метод start, вы также должны
// переопределить isFinished и отправлять kvo нотификации, когда ваша
// операция будет выполнена или отменена.
//
// isCancelled означает, что запрос об отмене операции был отправлен.
// Поддержку отмены операции вы должны реализовать самостоятельно.
//
// main() - определяет основной функционал
// (функционал можно определить в функции `start()`,
// но лучше определять в `main()`, чтобы разделить код
// бизнесс логики выполнения операции и ее запуска)
//
// start() - начать выполнение операции

// Operation vs DispatchWorkItem
// Operation - можно отменить во время ее выполнения

// BlockOperation example

class BlockOperationTest {
    private let operationQueue = OperationQueue()

    func test() {
        let block = BlockOperation {
            print("test")
        }
        operationQueue.addOperation(block)
    }
}

//let blockOperationTest = BlockOperationTest()
//blockOperationTest.test()

// Operation KVO example

// OperationQueue слушает свойства Operation, т.о OperationQueue
// понимает когда начинать выполнение новой операции.

// Основные свойства на которые можно добавить observer.
// isCancelled
// isAsynchronous
// isExecuting
// isFinished
// isReady
// dependencies
// completionBlock

class OperationKVOTest: NSObject {

    func test() {
        let operation = Operation()
        operation.addObserver(
            self,
            forKeyPath: "isFinished",
            options: .new,
            context: nil
        )
        operation.start()
    }

    override
    func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?) {

        if keyPath == "isFinished" {
            // handle
            print("""
                  "keyPath": \(String(describing: keyPath))
                  "object": \(String(describing: object))
                  "change": \(String(describing: change))
                  """)
        }
    }
}

let operationKVOTest = OperationKVOTest()
operationKVOTest.test()
