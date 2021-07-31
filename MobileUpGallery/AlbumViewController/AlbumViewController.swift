//
//  AlbumViewController.swift
//  MobileUpGallery
//
//  Created by Lazzat Seiilova on 29.07.2021.
//

import UIKit
import VKSdkFramework

protocol PhotoSelectionDelegate {
    func didChoosePhoto(urlString: String, date: String)
}

class AlbumViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    var delegate: PhotoSelectionDelegate?
    
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMMM YYYY"
        return dt
    }()
    
    var photos = [PhotoInfo]()
    var photoLinks = [String]()
    var photoDates = [String]()
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNavBarItems()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AlbumCollectionViewCell.nib(), forCellWithReuseIdentifier: AlbumCollectionViewCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.didChoosePhoto(urlString: photoLinks[indexPath.row], date: photoDates[indexPath.row])
        print("tapped date: \(photoDates[indexPath.row]) AND url \(photoLinks[indexPath.row])")
        
        let photoVC = PhotoViewController()
        navigationController?.pushViewController(photoVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.identifier, for: indexPath) as! AlbumCollectionViewCell
        
        fetcher.getResponse { (response) in
            guard let response = response else { return }
            for item in response.items {
                self.photos = item.sizes
                for x in 0..<self.photos.count {
                    let photo = self.photos[x]
                    if photo.type == "z" {
                        let urlString = photo.url
                        self.photoLinks.append(urlString)
                    }
                }
                let date = Date(timeIntervalSince1970: item.date)
                let dateTitle = self.dateFormatter.string(from: date)
                self.photoDates.append(dateTitle)
            }
            cell.imageView.downloaded(from: self.photoLinks[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as? UICollectionViewFlowLayout
        layout!.minimumInteritemSpacing = 2.0
        layout!.minimumLineSpacing = 2.0
        let spacing: CGFloat = (layout?.minimumInteritemSpacing ?? 0.0) + (layout?.sectionInset.left ?? 0.0) + (layout?.sectionInset.right ?? 0.0)
        let sideSize: CGFloat = (collectionView.frame.size.width - spacing) / 2.0
        return CGSize(width: sideSize, height: sideSize)
    }
    
    func createNavBarItems() {
        let albumTitle = UILabel()
        albumTitle.font = UIFont(name: "SF Pro Display", size: 18)
        albumTitle.tintColor = UIColor(named: "CustomBlack")
        albumTitle.text = "Mobile Up Gallery"
        self.title = albumTitle.text
        
        let rightExitButtonTitle = UILabel()
        rightExitButtonTitle.font = UIFont(name: "SF Pro Display", size: 18)
        rightExitButtonTitle.textColor = UIColor(named: "CustomBlack")
        rightExitButtonTitle.text = "Выход"
        
        let navigationRightButton = UIBarButtonItem(title: rightExitButtonTitle.text, style: .plain, target: self, action: #selector(exitVK))
        navigationRightButton.tintColor = UIColor(named: "CustomBlack")
        
        self.navigationItem.rightBarButtonItem = navigationRightButton
    }
    
    @objc func exitVK(sender: UIBarButtonItem) {
        VKSdk.forceLogout()
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
