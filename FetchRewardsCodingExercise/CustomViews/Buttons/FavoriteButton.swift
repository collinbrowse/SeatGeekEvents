//
//  FavoriteButton.swift
//  FetchRewardsCodingExercise
//
//  Created by Collin Browse on 1/8/21.
//

import UIKit

class FavoriteButton: UIButton {
    
    let symbolConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .light)
    lazy var filledImage = UIImage(systemName: "heart.fill", withConfiguration: symbolConfig)
    lazy var regularImage =  UIImage(systemName: "heart", withConfiguration: symbolConfig)
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                tintColor = .systemRed
                setImage(filledImage, for: .normal)
            } else {
                tintColor = .label
                setImage(regularImage, for: .normal)
            }
        }
    }
    
    
    convenience init(isSelected: Bool) {
        self.init()
        self.isSelected = isSelected
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
