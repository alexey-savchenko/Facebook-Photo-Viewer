//
//  PhotoListCell.swift
//  Facebook Photo Viewer
//
//  Created by Alexey Savchenko on 10.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import UIKit

class PhotoListCell: UICollectionViewCell {
  
  @IBOutlet weak var photoThumbnail: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  func configureWithPhoto(_ photo: Photo) {
    photoThumbnail.sd_setImage(with: photo.thumbnailURL, completed: nil)
  }
  
}
