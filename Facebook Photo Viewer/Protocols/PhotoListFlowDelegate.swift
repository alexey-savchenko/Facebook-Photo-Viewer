//
//  PhotoListFlowDelegate.swift
//  Facebook Photo Viewer
//
//  Created by Alexey Savchenko on 10.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import Foundation

protocol PhotoListFlowDelegate: class  {
  
  func didSelectPhoto(_ photo: Photo)
  
}
