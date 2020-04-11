//
//  ViewController.swift
//  conv3rter
//
//  Created by Zeeshan Hooda on 4/10/20.
//  Copyright © 2020 Deceptive Labs. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSWindowDelegate, NSTextFieldDelegate {
    
    // Main view nformation labels
    @IBOutlet weak var titleLabel   : NSTextField!
    @IBOutlet weak var versionLabel : NSTextField!
    
    // Main view text fields
    @IBOutlet weak var decimalTextField : NSTextField!
    @IBOutlet weak var binaryTextField  : NSTextField!
    @IBOutlet weak var hexTextField     : NSTextField!
    
    private lazy var converter = Converter()
    
    private let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    private let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    
    private func isTextField(inFocus textField: NSTextField) -> Bool {
        var inFocus = false
        inFocus = (textField.window?.firstResponder is NSTextView) && textField.window?.fieldEditor(false, for: nil) != nil && textField.isEqual(to: (textField.window?.firstResponder as? NSTextView)?.delegate)
        return inFocus
    }
    
    private func emptyTextField(_ textField: NSTextField) {
        textField.stringValue = ""
    }
    
    private func updateTextField(named textField: NSTextField, withString stringValue: String) {
        textField.stringValue = stringValue
    }
    
    internal func controlTextDidChange(_ obj: Notification) {
        if (isTextField(inFocus: decimalTextField)) {
            if (decimalTextField.stringValue != "" && decimalTextField.stringValue.isDecimal) {
                print("decimalTextField.inFocus = true")
                emptyTextField(binaryTextField)
                emptyTextField(hexTextField)
                let decimalValue = UInt64(decimalTextField.stringValue)!
                let binaryValue  = converter.decimalToBinary(dec: decimalValue)
                let hexValue     = converter.decimalToHex(dec: decimalValue)
                updateTextField(named: binaryTextField, withString: binaryValue)
                updateTextField(named: hexTextField, withString: hexValue)
            } else {
                emptyTextField(binaryTextField)
                emptyTextField(hexTextField)
            }
        }
        if (isTextField(inFocus: binaryTextField)) {
            if (binaryTextField.stringValue != "" && binaryTextField.stringValue.isBinary) { // && decimalTextField.stringValue.isBinary) {
                print("binaryTextField.inFocus = true")
                emptyTextField(decimalTextField)
                emptyTextField(hexTextField)
                let binaryValue  = binaryTextField.stringValue
                let decimalValue = converter.binaryToDecimal(bin: binaryValue)
                let hexValue     = converter.binaryToHex(bin: binaryValue)
                updateTextField(named: decimalTextField, withString: decimalValue)
                updateTextField(named: hexTextField, withString: hexValue)
            } else {
                emptyTextField(decimalTextField)
                emptyTextField(hexTextField)
            }
        }
        if (isTextField(inFocus: hexTextField)) {
            if (hexTextField.stringValue != "" && hexTextField.stringValue.isHex) {
                print("hexTextField.inFocus = true")
                emptyTextField(binaryTextField)
                emptyTextField(decimalTextField)
                let hexValue     = hexTextField.stringValue
                let binaryValue  = converter.hexToBinary(hex: hexValue)
                let decimalValue = converter.hexToDecimal(hex: hexValue)
                updateTextField(named: binaryTextField, withString: binaryValue)
                updateTextField(named: decimalTextField, withString: decimalValue)
            } else {
                emptyTextField(decimalTextField)
                emptyTextField(binaryTextField)
            }
        }
        if (decimalTextField.stringValue == "2020") {
            titleLabel.stringValue = "stayh0me"
        } else {
            titleLabel.stringValue = "conv3rter"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        versionLabel.stringValue = "v\(appVersion!) (\(buildVersion!))"
        
        decimalTextField.delegate = self
        binaryTextField.delegate  = self
        hexTextField.delegate     = self
    }
}


extension String {
    var isDecimal: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    var isBinary: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1"]
        return Set(self).isSubset(of: nums)
    }
    var isHex: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "a", "b", "c", "d", "e", "f"]
        return Set(self).isSubset(of: nums)
    }
}
