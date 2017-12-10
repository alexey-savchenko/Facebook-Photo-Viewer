//
//  FacebookAlbumPhotosFetcher.swift
//  Facebook Photo Viewer
//
//  Created by Alexey Savchenko on 10.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import Foundation
import FacebookCore
import SwiftyJSON

class FacebookAlbumPhotosFetcher: AlbumPhotoFetchService {
  
  func fetchPhotosOfAlbumWithID(_ ID: String, completion: @escaping ((Result<[Photo]>)->())) {
    
    let request = GraphRequest(graphPath: "\(ID)/photos",
      parameters: ["fields": "picture, name, images"],
      accessToken: AccessToken.current,
      httpMethod: .GET,
      apiVersion: GraphAPIVersion.defaultVersion)
    
    request.start({ (response, requestResult) in
      
      
      switch requestResult {
      case let .success(response):
        
        if let rawPhotosData = response.dictionaryValue?["data"] {
          if let jsonAlbums = JSON(rawPhotosData).array {
            
            let photos = jsonAlbums.flatMap { PhotoFactory.makePhotoFromJSON($0) }
            completion(Result.success(value: photos))
            
          } else { completion(Result.failure(error: "Cannot get photos")) }
        } else { completion(Result.failure(error: "Cannot get photos")) }
        
        
      case let .failed(error):
        completion(Result.failure(error: error.localizedDescription))
      }
      
    })
    
  }
  deinit {
    print("\(self) dealloc")
  }
}
