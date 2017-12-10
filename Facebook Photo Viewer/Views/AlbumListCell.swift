//
//  AlbumListCell.swift
//  Facebook Photo Viewer
//
//  Created by Alexey Savchenko on 10.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import UIKit
import SDWebImage

class AlbumListCell: UITableViewCell {
  
  @IBOutlet weak var albumThumbnailImageView: UIImageView!
  @IBOutlet weak var albumNameLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    
    
  }
  
  func configureWith(_ album: Album) {
    albumNameLabel.text = album.name
    albumThumbnailImageView.sd_setImage(with: album.thumbnailURL, completed: nil)
  }
  
}
