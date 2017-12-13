//
//  Result.swift
//  Facebook Photo Viewer
//
//  Created by Alexey Savchenko on 10.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import Foundation

///Enum used to hold results of operations done.
enum Result<T> {
  case success(value: T)
  case failure(error: String?)
}
