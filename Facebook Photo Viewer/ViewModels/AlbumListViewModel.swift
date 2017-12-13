//
//  AlbumListViewModel.swift
//  Facebook Photo Viewer
//
//  Created by Alexey Savchenko on 10.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import Foundation
import FacebookCore


class AlbumListViewModel: AlbumListViewModelType {
  
  var didLoadAlbums: ((Result<[Album]>) -> ())?
  
  func fetchAlbums() {
    
    webService.load(albumsResourse) { [unowned self] (result) in
      self.didLoadAlbums?(result)
    }
    
  }
  
  private let webService = WebService<[Album]>()
  
  private let albumsResourse = Resourse<[Album]>(request: GraphRequest(graphPath: "/me/albums",
                                                                       parameters: ["fields": "picture, name"],
                                                                       accessToken: AccessToken.current,
                                                                       httpMethod: .GET,
                                                                       apiVersion: GraphAPIVersion.defaultVersion)) { (jsonArray) -> [Album] in
                                                                        
                                                                        let albums = jsonArray.flatMap { AlbumFactory.makeAlbumFromJSON($0) }
                                                                        return albums
  }
  
  deinit {
    print("\(self) dealloc")
  }
}
