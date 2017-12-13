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
  
  weak var flowDelegate: AlbumListFlowDelegate?
  
  init(with viewModel: AlbumListViewModelType, flowDelegate: AlbumListFlowDelegate) {
    self.flowDelegate = flowDelegate
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc private func logoutButtonTap(){
    flowDelegate?.logoutTap()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let logOutItem = UIBarButtonItem(title: "Log out", style: .done, target: self, action: #selector(logoutButtonTap))
    navigationItem.rightBarButtonItems = [logOutItem]
    
    view.backgroundColor = .white
    
    navigationItem.title = "Album list"
    
    setUpAlbumList()
    
    viewModel.fetchAlbums()
    
    viewModel.didLoadAlbums = { [weak self] result in
      
      switch result {
        
      case .success(let albums):
        self?.albums = albums
        self?.albumsList.reloadData()
        
      case .failure(let error):
        self?.present(Utils.alertWithMessage(message: error!), animated: true, completion: nil)
        
      }
      
    }
    
  }
  
  
  private func setUpAlbumList() {
    
    albumsList.rowHeight = 150
    
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
  
  deinit {
    print("\(self) dealloc")
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
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    flowDelegate?.didSelectAlbum(albums[indexPath.row])
    
  }
  
}

