//
//  TrimStringRulable.swift
//  SwiftRuler
//
//  Created by Rawipon Srivibha on 6/6/19.
//

import Foundation

public class TrimStringRulable: NSObject, Rulable {
  
  private let rulable: Rulable
  private let trimmingCharacters: CharacterSet
  
  public init(rulable: Rulable, trimmingCharacters: CharacterSet) {
    self.rulable = rulable
    self.trimmingCharacters = trimmingCharacters
  }
  
  public var candidateValue: Any? {
    if let candidate = rulable.candidateValue as? String {
      return candidate.trimmingCharacters(in: trimmingCharacters)
    } else {
      return rulable.candidateValue
    }
  }
}

public extension Rulable {
  
  func rulable(byTrimmingStringIn trimmingCharacters: CharacterSet) -> Rulable {
    return TrimStringRulable(rulable: self, trimmingCharacters: trimmingCharacters)
  }
  
}
