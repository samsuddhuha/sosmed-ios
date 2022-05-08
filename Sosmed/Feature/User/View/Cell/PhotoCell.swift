//
//  PhotoCell.swift
//  Sosmed
//
//  Created by Paxel on 08/05/22.
//

import Foundation
import UIKit
import ImageViewer_swift

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imgAlbum: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCollectionCell(photo: String) {
        imgAlbum.downloaded(from: photo )
        imgAlbum.setupImageViewer(url: URL(string: photo)!)
    }

}
