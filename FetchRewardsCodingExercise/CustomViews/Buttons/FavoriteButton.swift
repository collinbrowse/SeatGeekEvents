//
//  FavoriteButton.swift
//  FetchRewardsCodingExercise
//
//  Created by Collin Browse on 1/8/21.
//

import UIKit

class FavoriteButton: UIButton {
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                tintColor = .systemRed
            } else {
                tintColor = .label
            }
        }
    }
    
    
    convenience init(isSelected: Bool) {
        self.init()
        self.isSelected = isSelected
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .light)
        let image = UIImage(systemName: "heart", withConfiguration: symbolConfig)
        setImage(image, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
