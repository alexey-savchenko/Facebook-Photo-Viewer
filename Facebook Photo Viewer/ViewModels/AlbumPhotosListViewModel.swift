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
  
  init(with fetchService: AlbumPhotoFetchService) {
    self.service = fetchService
  }
  
  func fetchPhotosOfAlbum(completion: @escaping ((Result<[Photo]>) -> ())) {
    service.fetchPhotosOfAlbum { (result) in
      completion(result)
    }
  }
  
  deinit {
    print("\(self) dealloc")
  }
  
}


