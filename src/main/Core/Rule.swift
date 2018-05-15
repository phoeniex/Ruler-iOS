//
//  Rule.swift
//  Pods
//
//  Created by Siwasit Anmahapong on 11/11/17.
//
//

import Foundation

@objc
public protocol Rule: class {
  func validate(candidate: Any?) -> Bool
}
