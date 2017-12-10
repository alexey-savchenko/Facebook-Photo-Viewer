//
//  FacebookAlbumFetcher.swift
//  Facebook Photo Viewer
//
//  Created by Alexey Savchenko on 10.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import Foundation
import FacebookCore
import SwiftyJSON

class FacebookAlbumFetcher: AlbumFetchService {
  
  func fetchAlbums(completion: @escaping ((Result<[Album]>) -> ())) {
    
    let request = GraphRequest(graphPath: "/me/albums",
                               parameters: ["fields": "picture, name"],
                               accessToken: AccessToken.current,
                               httpMethod: .GET,
                               apiVersion: GraphAPIVersion.defaultVersion)
    
    request.start({ (response, requestResult) in
      
      
      switch requestResult {
      case let .success(response):
        
        if let rawAlbumData = response.dictionaryValue?["data"] {
          if let jsonAlbums = JSON(rawAlbumData).array {
//            for item in jsonAlbums {
//              print(item)
//              print("-------------")
//            }
            
            let albums = jsonAlbums.flatMap { AlbumFactory.makeAlbumFromJSON($0) }
            completion(Result.success(value: albums))
            
          }
        }
        
        
      case let .failed(error):
        completion(Result.failure(error: error.localizedDescription))
      }
      
    })
  }
  
}
