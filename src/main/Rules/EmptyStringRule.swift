//
//  EmptyStringRule.swift
//  Pods
//
//  Created by Siwasit Anmahapong on 11/14/17.
//
//

import Foundation

open class EmptyStringRule: StringRule {
  
  var ignoreCharacterSet: CharacterSet

  public init(ignoreCharacterSet: CharacterSet = CharacterSet()) {
    self.ignoreCharacterSet = ignoreCharacterSet
  }
  
  open override func validate(string: String) -> Bool {
    return string.trimmingCharacters(in: ignoreCharacterSet).isEmpty == false
  }
  
}
