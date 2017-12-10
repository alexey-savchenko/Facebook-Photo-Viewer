//
//  AlbumPhotosListViewModel.swift
//  Facebook Photo Viewer
//
//  Created by Alexey Savchenko on 10.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import Foundation

class AlbumPhotosListViewModel: AlbumPhotosListViewModelType {
  
  private let service: AlbumPhotoFetchService
  
  private let albumID: String
  
  init(with fetchService: AlbumPhotoFetchService, albumID: String) {
    self.service = fetchService
    self.albumID = albumID
  }
  
  func fetchPhotosOfAlbumWithID(completion: @escaping ((Result<[Photo]>) -> ())) {
    service.fetchPhotosOfAlbumWithID(albumID) { (result) in
      completion(result)
    }
  }
  
  deinit {
    print("\(self) dealloc")
  }
}
