//
//  AlbumFlowCoordinator.swift
//  Facebook Photo Viewer
//
//  Created by Alexey Savchenko on 10.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import Foundation
import UIKit

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
  
  
}

extension AlbumFlowCoordinator: AlbumListFlowDelegate {
  
  func didSelectAlbum(_ album: Album) {
    
    print(album)
    
    
    
  }
  
}
