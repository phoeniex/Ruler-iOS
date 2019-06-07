//
//  DateTimeValidationViewController.swift
//  SwiftRuler
//
//  Created by Rawipon Srivibha on 6/1/17.
//  Copyright © 2017 Rawipon. All rights reserved.
//

import Foundation
import UIKit
import SwiftRuler

class DateTimeValidationViewController: UIViewController {

  @IBOutlet fileprivate weak var dateTimeTextField: UITextField!
  @IBOutlet fileprivate weak var resultLabel: UILabel!

  var ruler = Ruler<String>()
  var dateFormatter = DateFormatter()

  override func viewDidLoad() {
    super.viewDidLoad()

    dateFormatter.dateFormat = "dd/MM/yy"
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    dateFormatter.locale = Locale.current

    let oldDate = Date()
    let calender = Calendar.current
    var components = calender.dateComponents([.year, .month, .day], from: oldDate)

    components.hour = 0
    components.minute = 0
    components.hour = 0

    let newDate = calender.date(from: components)
    let rule = DateTimeRule(min: newDate, max: Date(timeIntervalSinceNow: 604800), formatter: dateFormatter.dateFormat)
    ruler.add(dateTimeTextField, rule: rule, userInfo: "Date is not in range (present to next 7 days)")
    dateTimeTextField.delegate = self
  }

  @IBAction func submit(_ sender: Any) {
    var isSuccess = false

    guard let dateTimeString = dateTimeTextField.text else { return }

    if dateFormatter.date(from: dateTimeString) != nil {
      if let error = ruler.validate() {
        resultLabel.text = error.userInfo as? String
      } else {
        resultLabel.text = "Success!"
        isSuccess = true
      }
    } else {
      resultLabel.text = "Incorrect date format"
    }

    guard let sender = sender as? UIButton else { return }
    sender.backgroundColor = isSuccess ? #colorLiteral(red: 0.0229054559, green: 0.642948091, blue: 0.6001754403, alpha: 0.8) : #colorLiteral(red: 0.9607843137, green: 0.4549019608, blue: 0.5019607843, alpha: 0.8)
    sender.setTitleColor(isSuccess ? .white : .white, for: .normal)
  }
}

extension DateTimeValidationViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    submit(textField)
    return true
  }
}
