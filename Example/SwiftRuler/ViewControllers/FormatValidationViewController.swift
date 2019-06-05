//
//  FormatValidationViewController.swift
//  SwiftRuler
//
//  Created by Rawipon Srivibha on 6/1/17.
//  Copyright © 2017 Rawipon. All rights reserved.
//

import Foundation

class FormatValidatorViewController: UIViewController {

  @IBOutlet fileprivate weak var emailTextField: UITextField!
  @IBOutlet fileprivate weak var resultLabel: UITextField!

  var ruler = Ruler()

  override func viewDidLoad() {
    super.viewDidLoad()

    do {
      let regexRule = try RegexRule(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$")
      ruler.add(emailTextField, rule: regexRule, userInfo: "Incorrect email format.")
    } catch {}

    emailTextField.delegate = self
  }
  @IBAction func submit(_ sender: Any) {
    var isSuccess = false

    if let error = ruler.validate() {
      resultLabel.text = error.userInfo as? String
    } else {
      resultLabel.text = "Success!"
      isSuccess = true
    }

    guard let sender = sender as? UIButton else { return }
    sender.backgroundColor = isSuccess ? #colorLiteral(red: 0.0229054559, green: 0.642948091, blue: 0.6001754403, alpha: 0.8) : #colorLiteral(red: 0.9607843137, green: 0.4549019608, blue: 0.5019607843, alpha: 0.8)
    sender.setTitleColor(isSuccess ? .white : .white, for: .normal)
  }
}

extension FormatValidatorViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    submit(textField)
    return true
  }
}
