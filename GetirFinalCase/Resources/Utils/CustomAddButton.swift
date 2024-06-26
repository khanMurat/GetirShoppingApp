//
//  CustomAddButton.swift
//  GetirFinalCase
//
//  Created by Murat on 12.04.2024.
//

import Foundation
import UIKit

final class CustomAddButton : UIButton {
    
    private var originalTitle : String?
    private var activityIndicator : UIActivityIndicatorView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.setTitle("Sepete Ekle", for: .normal)
        self.backgroundColor = .color_purple
        self.tintColor = .white
        self.layer.cornerRadius = 10
    }
    
    func showLoading(){
        
        originalTitle = title(for: .normal)
        setTitle("", for: .normal)
        
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        
        showActivityIndicator()
    }
    
    func hideLoading() {
        setTitle(originalTitle, for: .normal)
        activityIndicator?.removeFromSuperview()
        activityIndicator = nil
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = self.titleColor(for: .normal)
        return activityIndicator
    }
    
    private func showActivityIndicator() {
        guard let activityIndicator = activityIndicator else { return }
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerX,
                                                   multiplier: 1,
                                                   constant: 0)
        let yCenterConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerY,
                                                   multiplier: 1,
                                                   constant: 0)
        addConstraints([xCenterConstraint, yCenterConstraint])
    }
}
