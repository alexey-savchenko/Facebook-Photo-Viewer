//
//  AppCoordinator.swift
//  Facebook Photo Viewer
//
//  Created by Alexey Savchenko on 08.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import Foundation
import UIKit
import FacebookCore
import FBSDKLoginKit
import FacebookLogin

protocol Coordinator: class {
  
  var rootViewController: UIViewController { get }
  var childCoordinators: [Coordinator] { get set }
  func start()
  
}

extension Coordinator {
  func addChildCoordinator(_ coordinator: Coordinator) {
    childCoordinators.append(coordinator)
  }
  func removeChildCoordinator(_ coordinator: Coordinator) {
    self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
  }
}

class AppCoordinator: Coordinator {
  
  // MARK: - Properties
  
  var childCoordinators = [Coordinator]()
  
  var rootViewController: UIViewController {
    return self.navigationController
  }
  
  /// Window to manage
  let window: UIWindow
  
  private lazy var navigationController: UINavigationController = {
    let navigationController = UINavigationController()
    return navigationController
  }()
  
  // MARK: - Init
  public init(window: UIWindow) {
    self.window = window
    
    self.window.rootViewController = self.rootViewController
    self.window.makeKeyAndVisible()
  }
  
  // MARK: - Functions
  
  /// Starts the coordinator
  public func start() {
    //Detemine what vc to launch
    

    
    if FBSDKAccessToken.current() == nil {
      //Log in
      let loginVC = LoginVC()
      loginVC.delegate = self
      navigationController.viewControllers = [loginVC]

    } else {
      
      let albumListCoordinator = AlbumFlowCoordinator(with: self)
      albumListCoordinator.start()
      
      rootViewController.present(albumListCoordinator.rootViewController,
                                 animated: true, completion: nil)
      
    }
    
  }
  
  deinit {
    print("\(self) dealloc")
  }
  
}

extension AppCoordinator: LoginFlowDelegate {
  
  func didFinishLoginFlow(with result: Result<FacebookUserID>) {
    
    switch result {
      
    case let .success(userID):
      
      //Store user id in UserDefaults
      UserDefaults.standard.set(userID, forKey: "currentUserID")
      
      let albumListCoordinator = AlbumFlowCoordinator(with: self)
      albumListCoordinator.start()
      
      rootViewController.present(albumListCoordinator.rootViewController,
                                 animated: true, completion: nil)

    case let .failure(error):
      
      print(error)
      
    }
    
  }

}

extension AppCoordinator: FlowCoordinatorDelegate {
  
  func dissmisFlow(of coordinator: Coordinator) {
    
    LoginManager().logOut()
    
    childCoordinators = childCoordinators.filter { $0 !== coordinator }
    coordinator.rootViewController.dismiss(animated: true, completion: nil)
    
    let loginVC = LoginVC()
    loginVC.delegate = self
    navigationController.viewControllers = [loginVC]
    
  }

}
