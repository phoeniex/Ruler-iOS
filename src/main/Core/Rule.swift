//
//  Rule.swift
//  Pods
//
//  Created by Siwasit Anmahapong on 11/11/17.
//
//

import Foundation

public protocol Rule: class {
  func validate(candidate: Any?) -> Bool
}
