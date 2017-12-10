//
//  AlbumListVC.swift
//  Facebook Photo Viewer
//
//  Created by Alexey Savchenko on 10.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import UIKit

class AlbumListVC: UIViewController {
  
  private var viewModel: AlbumListViewModelType
  
  private var albums = [Album]()
  
  private let albumsList = UITableView()
  
  init(with viewModel: AlbumListViewModelType) {
   
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    viewModel.fetchAlbums { [weak self] (albums) in
      
      guard let `self` = self else { return }
      
      self.albums = albums
      
    }
    
  }
  
  
  private func setUpAlbumList() {
    albumsList.delegate = self
    albumsList.dataSource = self
    
    albumsList.register(UINib(nibName: "AlbumListCell", bundle: nil),
                                 forCellReuseIdentifier: "AlbumListCell")
    
    view.addSubview(albumsList)
    albumsList.translatesAutoresizingMaskIntoConstraints = false
    
    let safeArea = view.safeAreaLayoutGuide
    
    NSLayoutConstraint.activate([albumsList.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                                 albumsList.topAnchor.constraint(equalTo: safeArea.topAnchor),
                                 albumsList.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
                                 albumsList.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)])
  }
  
}

extension AlbumListVC: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return albums.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumListCell", for: indexPath) as! AlbumListCell
    cell.selectionStyle = .none
    cell.configureWith(albums[indexPath.row])
    return cell
    
  }
  
  
  
  
}
