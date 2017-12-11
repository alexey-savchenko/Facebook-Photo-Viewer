//
//  DataFetcher.swift
//  Facebook Photo Viewer
//
//  Created by iosUser on 11.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import Foundation

protocol DataFetcher {
  
  associatedtype Data
  
  var dataIsFetched: (([Data])->())? { get set }
  
  func fetch()
  
}
