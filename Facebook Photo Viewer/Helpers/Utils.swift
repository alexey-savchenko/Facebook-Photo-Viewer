//
//  Utils.swift
//  Facebook Photo Viewer
//
//  Created by Alexey Savchenko on 10.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import Foundation
import UIKit


class Utils {
  
  static func alertWithMessage(message: String) -> UIAlertController {
    
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    return alert
    
  }
}
