//
//  AlbumCollectionViewCell.swift
//  MobileUpGallery
//
//  Created by Lazzat Seiilova on 31.07.2021.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    
    static let identifier = "AlbumCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public func configure(with image: UIImage) {
        imageView.image = image
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "AlbumCollectionViewCell", bundle: nil)
    }
}
