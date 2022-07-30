//
//  ContentCollectionViewCell.swift
//  NetflixStyleSampleApp
//
//  Created by 이진희 on 2022/07/29.
//

import UIKit
import SnapKit

class ContentCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        contentView.backgroundColor = .purple
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { $0.edges.equalToSuperview()
            
        }
    }
}
