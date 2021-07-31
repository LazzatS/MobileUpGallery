//
//  PhotoViewController.swift
//  MobileUpGallery
//
//  Created by Lazzat Seiilova on 31.07.2021.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet var photoView: UIImageView!
    
    var photoImageURL: String?
    var photoImageDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoView.downloaded(from: photoImageURL!)
        self.title = photoImageDate
    }
}
