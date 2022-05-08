//
//  AlbumCell.swift
//  Sosmed
//
//  Created by Paxel on 08/05/22.
//

import Foundation
import UIKit

class AlbumCell: UITableViewCell {
    
    @IBOutlet weak var labelNameAlbum: UILabel!
    @IBOutlet weak var collectionPhoto: UICollectionView!
    
    private var viewModel : UserViewModel!
    
    var listPhoto = [Photo]()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViewModel()
    }
    
    private func setupViewModel(){
        viewModel = UserViewModel()
        
        viewModel.successListPhoto = { dataPhotos in
            self.listPhoto.removeAll()
            self.listPhoto = dataPhotos
            self.collectionPhoto.reloadData()
        }
        
    }
    
    func setupViewCell(dataAlbum: Album) {
        labelNameAlbum.text = dataAlbum.title
        viewModel.getAlbumPhotos(id: dataAlbum.id)
        
        collectionPhoto.delegate = self
        collectionPhoto.dataSource = self
        collectionPhoto.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension AlbumCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listPhoto.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionPhoto.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let dataPhoto = listPhoto[indexPath.row]
        cell.setupCollectionCell(photo: dataPhoto.thumbnailUrl)
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dataPhoto = listPhoto[indexPath.row]
        
        print("Tess \(dataPhoto.thumbnailUrl)")
    }
}
