//
//  CustomRule.swift
//  SwiftRuler_Example
//
//  Created by Rawipon Srivibha on 6/6/19.
//  Copyright © 2019 Rawipon. All rights reserved.
//

import Foundation
import SwiftRuler

class CustomRule: Rule {
  
  func validate(candidate: Any?) -> Bool {
    guard let stringCandidate = candidate as? String else {
      return false
    }
    
    return stringCandidate.rangeOfCharacter(from: CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZ")) != nil
  }
  
}
