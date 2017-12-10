//
//  AlbumListViewModelType.swift
//  Facebook Photo Viewer
//
//  Created by Alexey Savchenko on 10.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import Foundation

protocol AlbumListViewModelType: class {
  
  func fetchAlbums(completion: @escaping ((Result<[Album]>)->()))
  
}
