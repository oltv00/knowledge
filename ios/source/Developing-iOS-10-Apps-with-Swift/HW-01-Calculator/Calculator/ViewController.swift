import UIKit

class ViewController: UIViewController {

    // MARK: - UI properties
    @IBOutlet weak var display: UILabel!

    // MARK: - Private properties
    fileprivate var userIsInTheMiddleOfTyping = false
    fileprivate var brain: CalculatingBrain = CalculatorBrain()

    fileprivate var displayValue: Double {
        get {
            guard let displayText = display.text,
                let doubleValue = Double(displayText) else {
                assertionFailure("displayValue unavailable")
                return 0
            }

            return doubleValue
        }
        set {
            display.text = String(newValue)
        }
    }
}

// MARK: - Actions
extension ViewController {
    @IBAction func touchDigit(_ sender: UIButton) {
        guard let digit = sender.titleLabel?.text else {
            assertionFailure("Title is nil")
            return
        }

        print("touchDigit was called with text = \(digit)")

        guard let textCurrentlyInDisplay = display.text else {
            assertionFailure("Display text is nil")
            return
        }

        if userIsInTheMiddleOfTyping {
            display.text = textCurrentlyInDisplay + digit
        } else {
            userIsInTheMiddleOfTyping = true
            display.text = digit
        }

    }
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.set(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }

        if let mathematicalSymbol = sender.currentTitle {
            brain.perform(operation: mathematicalSymbol)
        }

        if let result = brain.result {
            displayValue = result
        }
    }
}
