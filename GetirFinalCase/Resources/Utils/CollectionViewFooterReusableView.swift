//
//  CollectionViewFooterReusableView.swift
//  GetirFinalCase
//
//  Created by Murat on 15.04.2024.
//

import Foundation
import UIKit

final class CollectionViewFooterReusableView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemGray6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
