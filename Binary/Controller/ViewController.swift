//
//  ViewController.swift
//  Binary
//
//  Created by William Bodily on 7/30/18.
//  Copyright © 2018 William Bodily. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let placeholder = NSAttributedString(string: "Enter a value...", attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), NSAttributedStringKey.font: UIFont(name: "Menlo", size: 36.0)!])

    @IBOutlet weak var valueEntryTextField: UITextField!
    @IBOutlet weak var binaryButton: UIButton!
    @IBOutlet weak var decimalButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        valueEntryTextField.attributedPlaceholder = placeholder
        valueEntryTextField.addTarget(self, action: #selector(textFieldTextDidChange), for: .editingChanged)
        toggleButtons(buttonState: false, buttonOpacity: 0.5)
    }
    
    @objc func textFieldTextDidChange() {
        if valueEntryTextField.text == "" {
            toggleButtons(buttonState: false, buttonOpacity: 0.5)
        } else {
            toggleButtons(buttonState: true, buttonOpacity: 1.0)
        }
    }
    
    func toggleButtons(buttonState: Bool, buttonOpacity: CGFloat) {
        binaryButton.isEnabled = buttonState
        binaryButton.alpha = buttonOpacity
        decimalButton.isEnabled = buttonState
        decimalButton.alpha = buttonOpacity
    }

    @IBAction func binaryButtonWasPressed(_ sender: Any) {
        if valueEntryTextField.text != "" {
            binaryButton.alpha = 1.0
            decimalButton.alpha = 0.5
            var index = 1
            var newString: String = ""
            guard let strings: [String] = (valueEntryTextField.text?.components(separatedBy: CharacterSet.whitespaces)) else { return }
            for string in strings {
                let intFromString = Int(string)!
                let binaryDigit = BinaryDecimal(intFromString)
                newString += "\(binaryDigit.calculateBinaryValueForInt())"
                if index < strings.count {
                    newString += " "
                    index = index + 1
                }
            }
            valueEntryTextField.text = newString
        }
    }
    
    @IBAction func decimalButtonWasPressed(_ sender: Any) {
        if valueEntryTextField.text != "" {
            binaryButton.alpha = 0.5
            decimalButton.alpha = 1.0
            var index = 1
            var newString: String = ""
            guard let strings: [String] = (valueEntryTextField.text?.components(separatedBy: CharacterSet.whitespaces)) else { return }
            for string in strings {
                let bitsFromString = string.map { Int(String($0))! }
                let binaryDigit = BinaryDecimal(bitsFromString)
                newString += "\(binaryDigit.calculateIntValueForBinary())"
                if index < strings.count {
                    newString += " "
                    index = index + 1
                }
            }
            valueEntryTextField.text = newString
        }
    }
    
}

