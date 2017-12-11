//
//  AlbumPhotosListViewModelType.swift
//  Facebook Photo Viewer
//
//  Created by Alexey Savchenko on 10.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import Foundation

protocol AlbumPhotosListViewModelType: class  {
  
  func fetchPhotosOfAlbum(completion: @escaping ((Result<[Photo]>)->()))
  
}
