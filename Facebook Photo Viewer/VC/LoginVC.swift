//
//  ViewController.swift
//  Facebook Photo Viewer
//
//  Created by iosUser on 08.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FBSDKLoginKit

class LoginVC: UIViewController {
  
  let loginManager = LoginManager()
  
  var delegate: LoginFlowDelegate?
  
  let loginButton = UIButton()
  
  let logOutButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    navigationItem.title = "Log In"
    
    setUp()
    
  }
  
  private func setUp() {
    
    loginButton.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(loginButton)
    NSLayoutConstraint.activate([loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                 loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                 loginButton.heightAnchor.constraint(equalToConstant: 44),
                                 loginButton.widthAnchor.constraint(equalToConstant: 200)])
    
    loginButton.setTitle("Continue via Facebook", for: .normal)
    loginButton.addTarget(self, action: #selector(loginButtonTap(_:)), for: .touchUpInside)
    loginButton.setTitleColor(.blue, for: .normal)
    loginButton.setTitleColor(UIColor.lightGray, for: .highlighted)
    
    logOutButton.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(logOutButton)
    NSLayoutConstraint.activate([logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                 logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
                                 logOutButton.heightAnchor.constraint(equalToConstant: 44),
                                 logOutButton.widthAnchor.constraint(equalToConstant: 200)])
    
    logOutButton.setTitle("Log out", for: .normal)
    logOutButton.addTarget(self, action: #selector(logoutButtonTap(_:)), for: .touchUpInside)
    logOutButton.setTitleColor(.blue, for: .normal)
    logOutButton.setTitleColor(UIColor.lightGray, for: .highlighted)
    
  }
  
  @objc private func logoutButtonTap(_ sender: UIButton) {
    loginManager.logOut()
    print("Logged out")
  }
  
  @objc private func loginButtonTap(_ sender: UIButton) {
    
    loginManager.logIn(readPermissions: [ReadPermission.userPhotos,
                                         ReadPermission.publicProfile], viewController: self) { [weak self] (loginResult) in
                        
                        guard let `self` = self else { return }
                        
                        switch loginResult {
                          
                        case let .failed(error):
                          
                          self.present(Utils.alertWithMessage(message: error.localizedDescription),
                                       animated: true, completion: nil)

                        case let .success(grantedPermissions: granted, declinedPermissions: declined, token: token):
                          
                          if let currentUserID = token.userId {                            
                            self.delegate?.didFinishLoginFlow(with: Result.success(value: currentUserID))
                          } else {
                            self.delegate?.didFinishLoginFlow(with: Result.failure(error: "Cennot get user ID."))
                          }
                          
                        default:
                          break
                          
                        }
                        
    }
    
  }
}

