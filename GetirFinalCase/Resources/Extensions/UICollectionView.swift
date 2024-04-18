//
//  UICollectionViewExtension.swift
//  GetirFinalCase
//
//  Created by Murat on 13.04.2024.
//

import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }
    
    func register<T: UICollectionViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach {
            register(cellType: $0, bundle: bundle)
        }
    }
    
    func register<T: UICollectionViewCell>(cellClass: T.Type) {
        let className = cellClass.className
        register(cellClass, forCellWithReuseIdentifier: className)
    }
    
    func registerHeader<T: UICollectionReusableView>(viewType : T.Type) {
        
        let className = viewType.className
        
        register(viewType, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: className)
    }
    
    func registerFooter<T: UICollectionReusableView>(viewType : T.Type) {
        
        let className = viewType.className
        
        register(viewType, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: className)
    }
    
    
    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        
        return self.dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
    }
    
    func dequeueReusableHeaderView<T: UICollectionReusableView>(with type : T.Type, for indexPath : IndexPath) -> T {
        
        let header = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: type.className, for: indexPath) as! T
        
        return header
    }
    
    func dequeueReusableFooterView<T: UICollectionReusableView>(with type : T.Type, for indexPath : IndexPath) -> T {
        
        let footer = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: type.className, for: indexPath) as! T
        
        return footer
    }
}

