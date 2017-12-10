//
//  LoginFlowDelegate.swift
//  Facebook Photo Viewer
//
//  Created by Alexey Savchenko on 10.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import Foundation

typealias FacebookUserID = String

protocol LoginFlowDelegate {
  
  func didFinishLoginFlow(with result: Result<FacebookUserID>)
  
}
