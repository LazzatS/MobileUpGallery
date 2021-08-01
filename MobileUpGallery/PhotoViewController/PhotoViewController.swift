//
//  PhotoViewController.swift
//  MobileUpGallery
//
//  Created by Lazzat Seiilova on 31.07.2021.
//

import UIKit

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    }
}

class PhotoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    @IBOutlet var photoView: UIImageView!
    @IBOutlet var photoCollectionView: UICollectionView!
    
    var photoImageURL: String?
    var photoImageDate: String?
    var photos = [PhotoInfo]()
    var photoLinks = [String]()
    var photoDates = [String]()
    var dateFormatter: DateFormatter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoView.downloaded(from: photoImageURL!)
        self.title = photoImageDate
        createNavBarItems()
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.register(PhotoCollectionViewCell.nib(), forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        photoView.downloaded(from: photoLinks[indexPath.row])
        self.title = photoDates[indexPath.row]
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 17
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell

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
                let dateTitle = self.dateFormatter!.string(from: date)
                self.photoDates.append(dateTitle)
            }
            cell.photoImageView.downloaded(from: self.photoLinks[indexPath.row])
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let layout = collectionViewLayout as? UICollectionViewFlowLayout

        layout?.scrollDirection = .horizontal
        layout!.minimumInteritemSpacing = 2.0
        layout!.minimumLineSpacing = 0.0

        let sideSize: CGFloat = 56
        return CGSize(width: sideSize, height: sideSize)
    }
    
    func createNavBarItems() {
        
        let rightShareButtonImage = UIImage(systemName: "square.and.arrow.up")
        let navigationRightButton = UIBarButtonItem(image: rightShareButtonImage, style: .plain, target: self, action: #selector(save))
        navigationRightButton.tintColor = UIColor(named: "CustomBlack")
        self.navigationItem.rightBarButtonItem = navigationRightButton
    }
    
    @objc func save() {
        let items: [Any] = [UIImage()]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)

        guard let image = photoView.image else { return }
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: image)
        showAlert()
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Успех", message: "Вы сохранили фото.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
