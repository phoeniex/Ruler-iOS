//
//  Primitive+Ruler.swift
//  SwiftRuler
//
//  Created by Rawipon Srivibha on 26/12/18.
//

import Foundation

extension String: Rulable {
  public var candidateValue: Any? {
    return self
  }
}

extension Int: Rulable {
  public var candidateValue: Any? {
    return self
  }
}

extension Double: Rulable {
  public var candidateValue: Any? {
    return self
  }
}

extension Float: Rulable {
  public var candidateValue: Any? {
    return self
  }
}

extension Bool: Rulable {
  public var candidateValue: Any? {
    return self
  }
}
