//
//  AlbumPhotosListViewModel.swift
//  Facebook Photo Viewer
//
//  Created by Alexey Savchenko on 10.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import Foundation
import FacebookCore

class AlbumPhotosListViewModel: AlbumPhotosListViewModelType {
  
  var didLoadPhotos: ((Result<[Photo]>) -> ())?
  
  let albumID: String
  
  init(with albumID: String) {
    self.albumID = albumID
  }
  
  func fetchPhotosOfAlbum() {
    webService.load(albumPhotosResourse(albumID)) { [unowned self] (result) in
      self.didLoadPhotos?(result)
    }
  }
  
  private let webService = WebService<[Photo]>()
  
  private let albumPhotosResourse: (String) -> Resourse<[Photo]> = { albumID in
    
    return Resourse<[Photo]>(request: GraphRequest(graphPath: "\(albumID)/photos",
      parameters: ["fields": "picture, name, images"],
      accessToken: AccessToken.current,
      httpMethod: .GET,
      apiVersion: GraphAPIVersion.defaultVersion), parse: { (jsonArray) -> [Photo] in
        
        let photos = jsonArray.flatMap { PhotoFactory.makePhotoFromJSON($0) }
        return photos
        
    })
    
  }
  
  deinit {
    print("\(self) dealloc")
  }
  
}


