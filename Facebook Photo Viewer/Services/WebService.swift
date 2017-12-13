//
//  WebService.swift
//  Facebook Photo Viewer
//
//  Created by iosUser on 13.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import Foundation
import SwiftyJSON

final class WebService<A> {
  
  func load(_ resourse: Resourse<A>, completion: @escaping (Result<A>) -> ()) {
    
    resourse.request.start { (_, requestResult) in
      
      switch requestResult {
        
      case .success(response: let response):
        
        guard let rawData = response.dictionaryValue?["data"],
          let jsonArray = JSON(rawData).array else { completion(.failure(error: "Cannot get resourse.")); return }
        
        completion(Result<A>.success(value: resourse.parse(jsonArray)))
        
      case .failed(let error):
        completion(.failure(error: error.localizedDescription))
      }
      
    }
    
  }
  
}
