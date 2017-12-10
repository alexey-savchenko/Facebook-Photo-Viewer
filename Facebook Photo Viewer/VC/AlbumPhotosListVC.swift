//
//  AlbumPhotosList.swift
//  Facebook Photo Viewer
//
//  Created by Alexey Savchenko on 10.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import Foundation
import UIKit

class AlbumPhotosListVC: UIViewController {
  
  private var viewModel: AlbumPhotosListViewModelType
  
  private var albums = [Photo]()
  
  private let photoList = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  
  let flowDelegate: PhotoListFlowDelegate
  
  init(with viewModel: AlbumPhotosListViewModelType, photoListFlowDelegate: PhotoListFlowDelegate) {
    self.viewModel = viewModel
    self.flowDelegate = photoListFlowDelegate
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
    viewModel.fetchPhotosOfAlbumWithID { (result) in
      switch result {
      case let .success(photos):
        print(photos)
        break
      case let .failure(error):
        break
      }
    }
    
  }
  
  deinit {
    print("\(self) dealloc")
  }
}
