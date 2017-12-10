//
//  PhotoVC.swift
//  Facebook Photo Viewer
//
//  Created by Alexey Savchenko on 10.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import UIKit

class PhotoVC: UIViewController {
  
  private var imageURL: URL
  
  init(with imageURL: URL) {
    self.imageURL = imageURL
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  let imageView = UIImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    setUpAlbumList()
    
    imageView.sd_setImage(with: imageURL, completed: nil)
    
  }
  
  private func setUpAlbumList() {
    
    view.addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    let safeArea = view.safeAreaLayoutGuide
    
    NSLayoutConstraint.activate([imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                                 imageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
                                 imageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
                                 imageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)])
    
    imageView.contentMode = .scaleAspectFit
    
  }
  
  deinit {
    print("\(self) dealloc")
  }
  
}
