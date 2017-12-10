//
//  AlbumListViewModel.swift
//  Facebook Photo Viewer
//
//  Created by Alexey Savchenko on 10.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import Foundation

class AlbumListViewModel: AlbumListViewModelType {
  
  let service: AlbumFetchService
  
  init(withFetchService fetchService: AlbumFetchService) {
    service = fetchService
  }
  
  func fetchAlbums(completion: @escaping (([Album]) -> ())) {
    service.fetchAlbums { (albums) in
      completion(albums)
    }
  }
  
}
