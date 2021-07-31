//
//  PhotoCollectionViewCell.swift
//  MobileUpGallery
//
//  Created by Lazzat Seiilova on 01.08.2021.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet var photoImageView: UIImageView!
    
    static let identifier = "PhotoCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func configure(with image: UIImage) {
        photoImageView.image = image
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
    }
    
}
