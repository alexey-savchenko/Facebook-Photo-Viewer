//
//  PhotoFactory.swift
//  Facebook Photo Viewer
//
//  Created by Alexey Savchenko on 10.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import Foundation
import SwiftyJSON

class PhotoFactory {
  static func makePhotoFromJSON(_ json: JSON) -> Photo? {
    if let id = json["id"].string,
      let pictureURLString = json["picture"].string,
      let fullsizeImageURLString = json["images"].arrayValue[0]["source"].string {
      return Photo(thumbnailURL: URL(string: pictureURLString)!,
                   fullSizeImageURL: URL(string: fullsizeImageURLString)!,
                   ID: id)
    } else {
      return nil
    }
  }
}
