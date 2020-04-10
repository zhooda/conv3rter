//
//  ViewController.swift
//  conv3rter
//
//  Created by Zeeshan Hooda on 4/8/20.
//  Copyright © 2020 Deceptive Labs. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSWindowDelegate, NSTextFieldDelegate {
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var versionLabel: NSTextField!
    
    @IBOutlet weak var decimalTextField: NSTextField!
    @IBOutlet weak var binaryTextField: NSTextField!
    @IBOutlet weak var hexTextField: NSTextField!
    
    private let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    private let plagueYear = 2020
    
    var decimalString : String {
        get {
            print(decimalTextField.stringValue)
            return decimalTextField.stringValue
        }
    }
    
    @IBAction func testTypeAction(_ sender: Any) {
        let testVar: String = (sender as AnyObject).stringValue
        print(testVar)
    }
    
    @IBAction func convertButtonAction(_ sender: Any) {
        
        let decimal = UInt64(decimalTextField.doubleValue)
        let binString = "0b" + String(decimal, radix: 2)
        let hexString = "0x" + String(decimal, radix: 16).uppercased()
        
        // UPDATE TEXT FIELD PLACEHOLDERS WITH CALCULATED VALUES
        updateFieldPlaceholder(decimalTextField, String(decimal))
        updateFieldPlaceholder(binaryTextField, binString)
        updateFieldPlaceholder(hexTextField, hexString)

    }
    
    private func updateFieldPlaceholder(_ field: NSTextField, _ value: String) {
//        field.placeholderString = value
        field.stringValue = value
    }
    
    func makeBrokenWarning() {
        let alert = NSAlert.init()
        alert.messageText = "conv3rter v" + appVersion! + " is very broken."
        alert.informativeText = "This application is very broken at the moment. Please only use the decimal text field as all the other text fields do not function at the moment kthxbye."
        alert.addButton(withTitle: "Take me to crapville!")
        alert.runModal()
    }
    
    override func viewDidLoad() {
        let year = Calendar.current.component(.year, from: Date())
        if (year == plagueYear) {
            titleLabel.stringValue = "stay at h0me"
        }
        versionLabel.stringValue = "v" + appVersion!
        // make broken warning
        makeBrokenWarning()
        decimalTextField.delegate = self
    }
    
    func controlTextDidChange(_ obj: Notification) {
      let textField = obj.object as! NSTextField
      print(textField.stringValue)
      let decimal = UInt64(decimalTextField.doubleValue)
      let binString = "0b" + String(decimal, radix: 2)
      let hexString = "0x" + String(decimal, radix: 16).uppercased()
        
        updateFieldPlaceholder(decimalTextField, String(decimal))
        updateFieldPlaceholder(binaryTextField, binString)
        updateFieldPlaceholder(hexTextField, hexString)
    }
    
}

