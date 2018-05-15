//
//  CompareValidationViewController.swift
//  SwiftRuler
//
//  Created by Rawipon Srivibha on 6/1/18.
//  Copyright © 2018 Rawipon Srivibha. All rights reserved.
//

import Foundation

class CompareValidateViewController: UIViewController {

  @IBOutlet fileprivate weak var passwordTextField: UITextField!
  @IBOutlet fileprivate weak var confirmPasswordTextField: UITextField!
  @IBOutlet fileprivate weak var resultLabel: UILabel!

  var ruler = Ruler()
  var dateFormatter = DateFormatter()

  override func viewDidLoad() {
    super.viewDidLoad()

    let validatable = CompareRulable(candidate: passwordTextField, other: confirmPasswordTextField)
    ruler.add(validatable, rule: TrueRule(), userInfo: "Password is not match, Please try again.")

    passwordTextField.delegate = self
    confirmPasswordTextField.delegate = self
  }

  @IBAction func tapOnSubmit(_ sender: Any) {
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

extension CompareValidateViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    tapOnSubmit(textField)
    return true
  }
}
