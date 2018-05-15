//
//  ConnectToInternetRule.swift
//  Pods
//
//  Created by Siwasit Anmahapong on 11/14/17.
//
//

import Foundation
import Reachability

open class ConnectToInternetRule: NSObject, Rule {
  
  open func validate(candidate: Any? = nil) -> Bool {
    let reachability = Reachability.forInternetConnection()
    return reachability?.currentReachabilityStatus() != .NotReachable
  }
  
}
