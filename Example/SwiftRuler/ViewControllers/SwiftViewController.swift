//
//  SwiftViewController.swift
//  SwiftRuler
//
//  Created by Siwasit Anmahapong on 11/15/17.
//  Copyright © 2016 Rawipon Srivibha. All rights reserved.
//

import UIKit
import SwiftRuler

enum FormError {
  case emptyText
  case incorrectEmail
  case missingCapitalLetters
  case missingToggle
  case passwordMisMatch
  case noInternet
  
  func toString() -> String {
    switch self {
    case .emptyText: return "Text must not empty, ignoring space"
    case .incorrectEmail: return "Email format incorrect"
    case .missingCapitalLetters: return "Text must not contain CAPITAL letters."
    case .missingToggle: return "Toggle must be set to True."
    case .passwordMisMatch: return "Password is not the same."
    case .noInternet: return "No internet access."
    }
  }
}

class SwiftViewController: UIViewController {

  @IBOutlet fileprivate weak var emptyTestTextField: UITextField!
  @IBOutlet fileprivate weak var customValidateTextField: UITextField!
  @IBOutlet fileprivate weak var passwordTextField: UITextField!
  @IBOutlet fileprivate weak var confirmPasswordTextField: UITextField!
  @IBOutlet fileprivate weak var emptyTestErrorLabel: UILabel!
  @IBOutlet fileprivate weak var customValidateErrorLabel: UILabel!
  @IBOutlet fileprivate weak var validateResultLabel: UILabel!
  @IBOutlet fileprivate weak var trueValidateToggle: UISwitch!

  private var ruler = Ruler<FormError>()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupValidator()
  }

  private func setupValidator() {
    weak var weakSelf = self
    let passwordValidateBlock = RuleBlock {
      return weakSelf?.passwordTextField.text == weakSelf?.confirmPasswordTextField.text
    }

    ruler.add(emptyTestTextField,
              rules: [(EmptyStringRule(), .emptyText),
                      (EmailRule(), .incorrectEmail)])
    ruler.add(customValidateTextField, rule: CustomRule(), userInfo: .missingCapitalLetters)
    ruler.add(trueValidateToggle, rule: TrueRule(), userInfo: .missingToggle)

    ruler.add(passwordValidateBlock, rule: TrueRule(), userInfo: .passwordMisMatch)
  }

  func show(error: String, for label: UILabel) {
    label.text = error
  }

  @IBAction func tapOnSubmit(_ sender: Any?) {
    var isSuccess = false
    let errors = ruler.validateAll()
    if !errors.isEmpty {
      var resultStr = "Complete with \(errors.count) error(s)."
      for error in errors {
        guard let description = error.userInfo?.toString() else { return }
        resultStr += "\n\(description)"
      }
      validateResultLabel.text = resultStr
    } else {
      validateResultLabel.text = "Success!"
      isSuccess = true
    }

    guard let sender = sender as? UIButton else { return }
    sender.backgroundColor = isSuccess ? #colorLiteral(red: 0.0229054559, green: 0.642948091, blue: 0.6001754403, alpha: 0.8) : #colorLiteral(red: 0.9607843137, green: 0.4549019608, blue: 0.5019607843, alpha: 0.8)
    sender.setTitleColor(isSuccess ? .white : .white, for: .normal)
  }

}

extension SwiftViewController: UITextFieldDelegate {

  func textFieldDidEndEditing(_ textField: UITextField) {
    if textField == emptyTestTextField {
      guard !EmptyStringRule().validate(candidate: textField.text) else { return }
      show(error: "Text must not empty.", for: emptyTestErrorLabel)
    } else if textField == customValidateTextField {
      guard !(CustomRule() as Rule).validate(candidate: textField.text) else { return }
      show(error: "Text must not contain CAPITAL letters.", for: customValidateErrorLabel)
    }
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }

}
