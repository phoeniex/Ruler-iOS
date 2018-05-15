//
//  CompareRulable.swift
//  Pods
//
//  Created by Rawipon Srivibha on 6/1/18.
//
//

import Foundation

public struct CompareRulable: Rulable {
  public var candidate: Rulable
  public var otherCandidate: Rulable
  
  public init(candidate: Rulable, other: Rulable) {
    self.candidate = candidate
    self.otherCandidate = other
  }
  
  public var candidateValue: Any? {
    if let result = compareStringValue() { return result }
    if let result = compareNumericValue() { return result }
    
    return nil
  }
  
  func compareStringValue() -> Bool? {
    guard let value = candidate.candidateValue as? String,
      let otherValue = otherCandidate.candidateValue as? String else {
        return nil
    }
    
    return value == otherValue
  }
  
  func compareNumericValue() -> Bool? {
    guard let value = candidate.candidateValue as? NSNumber,
      let otherValue = otherCandidate.candidateValue as? NSNumber else {
        return nil
    }
    
    return value.doubleValue == otherValue.doubleValue
  }
}
