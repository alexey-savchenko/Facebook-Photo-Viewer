//
//  Resourse.swift
//  Facebook Photo Viewer
//
//  Created by iosUser on 13.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import Foundation
import FacebookCore
import SwiftyJSON

///Struct used to hold about Facebook resources that need to be downloaded.
struct Resourse<A> {
  let request: GraphRequest
  let parse: ([JSON]) -> A
}
