//
//  AlbumFactory.swift
//  Facebook Photo Viewer
//
//  Created by Alexey Savchenko on 10.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import Foundation
import SwiftyJSON

class AlbumFactory {
  static func makeAlbumFromJSON(_ json: JSON) -> Album? {
    
    if let urlString = json["picture"]["data"]["url"].string,
      let name = json["name"].string,
      let id = json["id"].string {
      return Album(name: name, ID: id, thumbnailURL: URL.init(string: urlString)!)
    } else {
      return nil
    }
    
  }
}
