//
//  LengthValidationViewController.swift
//  SwiftRuler
//
//  Created by Rawipon Srivibha on 6/1/18.
//  Copyright © 2018 Rawipon Srivibha. All rights reserved.
//

import Foundation
import UIKit
import SwiftRuler

class LengthValidationViewController: UIViewController {

  @IBOutlet fileprivate weak var lengthTextField: UITextField!
  @IBOutlet fileprivate weak var valueTextField: UITextField!
  @IBOutlet fileprivate weak var resultLabel: UILabel!

  var info: [String: String] = [:]
  var min = 0
  var max: Int = Int.max
  var inverted = false

  override func viewDidLoad() {
    super.viewDidLoad()

    info = ["error": "ERROR: Length must be < to \(lengthTextField.text!)"]
    valueTextField.delegate = self
  }

  @IBAction fileprivate func submit(_ sender: Any) {
    let rule = StringRangeRule(min...max, inverted: inverted)
    var isSuccess = false

    if rule.validate(string: valueTextField.text!) {
      resultLabel.text = "Success!"
      isSuccess = true
    } else {
      resultLabel.text = info["error"]
    }

    guard let sender = sender as? UIButton else { return }
    sender.backgroundColor = isSuccess ? #colorLiteral(red: 0.0229054559, green: 0.642948091, blue: 0.6001754403, alpha: 0.8) : #colorLiteral(red: 0.9607843137, green: 0.4549019608, blue: 0.5019607843, alpha: 0.8)
    sender.setTitleColor(isSuccess ? .white : .white, for: .normal)
  }

  @IBAction func changeScheme(control: UISegmentedControl) {
    let number = Int(lengthTextField.text!)!

    min = 0
    max = Int.max
    inverted = false

    switch control.selectedSegmentIndex {
    case 0:
      min = number
      max = number
      inverted = true
      info = ["error": "ERROR: Length must be != \(number)"]
    case 1:
      max = number
      info = ["error": "ERROR: Length must be <= \(number)"]
    case 2:
      max = number - 1
      inverted = true
      info = ["error": "ERROR: Length must be < \(number)"]
    case 3:
      min = number
      max = number
      info = ["error": "ERROR: Length must be == \(number)"]
    case 4:
      min = number + 1
      inverted = true
      info = ["error": "ERROR: Length must be > \(number)"]
    case 5:
      min = number
      info = ["error": "ERROR: Length must be >= \(number)"]
    default: break
    }
  }
}

extension LengthValidationViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    submit(textField)
    return true
  }
}
