//
//  FetchEventImageView.swift
//  FetchRewardsCodingExercise
//
//  Created by Collin Browse on 1/8/21.
//

import UIKit

class FetchEventImageView: UIImageView {

    let placeholderImage = Images.eventPlaceholder
    let cache = NetworkManager.shared.cache
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func downloadImage(fromURL urlString: String) {
        
        NetworkManager.shared.downloadImage(from: urlString) { (image) in
            if let image = image {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
        
    }

}
