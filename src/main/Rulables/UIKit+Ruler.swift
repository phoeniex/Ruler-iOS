//
//  UIKit+Ruler.swift
//  Pods
//
//  Created by Siwasit Anmahapong on 11/14/17.
//
//

import Foundation

extension UIView: Rulable {
  @objc public var candidateValue: Any? {
    print("Validator: Cannot validate \(type(of:self)), it don't have candidateValue")
    return nil
  }
}

extension UIButton {
  public override var candidateValue: Any? {
    return isSelected
  }
}

extension UITextField {
  public override var candidateValue: Any? {
    return text
  }
}

extension UITextView {
  public override var candidateValue: Any? {
    return text
  }
}

extension UISwitch {
  public override var candidateValue: Any? {
    return isOn
  }
}

extension UILabel {
  public override var candidateValue: Any? {
    return text
  }
}
