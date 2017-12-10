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
  
  private var photos = [Photo]()
  
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
    
    view.backgroundColor = .white
    
    setUpPhotoList()
    
    viewModel.fetchPhotosOfAlbumWithID { (result) in
      switch result {
      case let .success(photos):
        
        print(photos)
        self.photos = photos
        self.photoList.reloadData()
        
      case let .failure(error):
        self.present(Utils.alertWithMessage(message: error!), animated: true, completion: nil)
      }
    }
    
  }
  
  private func setUpPhotoList() {
    
    photoList.delegate = self
    photoList.dataSource = self
    
    photoList.register(UINib.init(nibName: "PhotoListCell", bundle: nil), forCellWithReuseIdentifier: "PhotoListCell")
    
    view.addSubview(photoList)
    photoList.translatesAutoresizingMaskIntoConstraints = false
    
    let safeArea = view.safeAreaLayoutGuide
    
    NSLayoutConstraint.activate([photoList.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                                 photoList.topAnchor.constraint(equalTo: safeArea.topAnchor),
                                 photoList.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
                                 photoList.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)])
  }
  
  deinit {
    print("\(self) dealloc")
  }
}

extension AlbumPhotosListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoListCell",
                                                  for: indexPath) as! PhotoListCell
    cell.configureWithPhoto(photos[indexPath.row])
    return cell
    
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: view.bounds.width / 2, height: view.bounds.width / 2)
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      didSelectItemAt indexPath: IndexPath) {
    
  }
  
}
