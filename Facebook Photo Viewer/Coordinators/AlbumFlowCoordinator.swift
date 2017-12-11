//
//  AlbumFlowCoordinator.swift
//  Facebook Photo Viewer
//
//  Created by Alexey Savchenko on 10.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import Foundation
import UIKit
import FacebookCore

class AlbumFlowCoordinator: Coordinator {
  
  private lazy var navigationController: UINavigationController = {
    let navigationController = UINavigationController()
    return navigationController
  }()
  
  var rootViewController: UIViewController {
    return navigationController
  }
  
  var childCoordinators: [Coordinator] = []
  
  func start() {
    
    let albumListViewModel = AlbumListViewModel(withFetchService: FacebookAlbumFetcher())
    let albumListVC = AlbumListVC(with: albumListViewModel, flowDelegate: self)
    navigationController.viewControllers = [albumListVC]
    
  }
  
  let albumFlowCoordinatorDelegate: FlowCoordinatorDelegate
  
  init(with coordinatorDelegate: FlowCoordinatorDelegate) {
    self.albumFlowCoordinatorDelegate = coordinatorDelegate
  }
  
  deinit {
    print("\(self) dealloc")
  }
  
}

extension AlbumFlowCoordinator: AlbumListFlowDelegate {
  
  func logoutTap() {
    albumFlowCoordinatorDelegate.dissmisFlow(of: self)
  }
  
  
  func didSelectAlbum(_ album: Album) {
    
    let albumPhotosListViewModel = AlbumPhotosListViewModel(with: FacebookAlbumPhotosFetcher(albumID: album.ID))
    let albumPhotosListVC = AlbumPhotosListVC(with: albumPhotosListViewModel,
                                              photoListFlowDelegate: self)
    
    navigationController.pushViewController(albumPhotosListVC, animated: true)
    
  }
  
}
extension AlbumFlowCoordinator: PhotoListFlowDelegate {
  
  func didSelectPhoto(_ photo: Photo) {
    print(photo)
    
    navigationController.pushViewController(PhotoVC.init(with: photo.fullSizeImageURL), animated: true)
    
  }
  
  
}
