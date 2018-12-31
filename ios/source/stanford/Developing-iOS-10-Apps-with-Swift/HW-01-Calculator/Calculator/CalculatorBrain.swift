import Foundation

protocol CalculatingBrain {
    var result: Double? { get }
    mutating func perform(operation: String)
    mutating func set(operand: Double)
}

struct CalculatorBrain {
    // MARK: - Private properties
    fileprivate var accumulator: Double?
    fileprivate var pendingBinaryOperation: PendingBinaryOperation?

    fileprivate var operations: Dictionary<String, Operation> = [
        "π":    .constant(.pi),
        "e":    .constant(M_E),
        "√":    .unary(sqrt),
        "cos":  .unary(cos),
        "±":    .unary{ -$0 },
        "×":    .binary{ $0 * $1 },
        "+":    .binary{ $0 + $1 },
        "−":    .binary{ $0 - $1 },
        "÷":    .binary{ $0 / $1 },
        "=":    .equals,
    ]

    // MARK: - Private additional models
    fileprivate enum Operation {
        case constant(Double)
        case unary((Double) -> Double)
        case binary((Double, Double) -> Double)
        case equals
    }

    fileprivate struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double

        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }

    // MARK: - Private funcs
    fileprivate mutating func performPendingBinaryOperation() {
        guard let operand = accumulator,
              let pbo = pendingBinaryOperation else { return }
        accumulator = pbo.perform(with: operand)
        pendingBinaryOperation = nil
    }
}

// MARK: - CalculatingBrain
extension CalculatorBrain: CalculatingBrain {
    var result: Double? {
        return accumulator
    }

    mutating func perform(operation: String) {
        if let operation = operations[operation] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unary(let function):
                guard let operand = accumulator else { return }
                accumulator = function(operand)
            case .binary(let function):
                guard let operand = accumulator else { return }
                pendingBinaryOperation = PendingBinaryOperation(function: function,
                                                                firstOperand: operand)
                accumulator = nil
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }

    mutating func set(operand: Double) {
        accumulator = operand
    }
}
