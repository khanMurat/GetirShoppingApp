//
//  LoadingView.swift
//  GetirFinalCase
//
//  Created by Murat on 11.04.2024.
//

import Foundation
import UIKit

class LoadingView {
    
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    static let shared = LoadingView()
    
    var blurView : UIVisualEffectView = UIVisualEffectView()
    
    private init() {
        configure()
    }
    
    func configure(){
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = UIWindow(frame: UIScreen.main.bounds).frame
        activityIndicator.center = blurView.center
        activityIndicator.hidesWhenStopped = true
        blurView.contentView.addSubview(activityIndicator)
    }
    
    func startLoading() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let window = windowScene.windows.first else { return }

        window.addSubview(blurView)
        activityIndicator.startAnimating()
    }

    
    func hideLoading() {
        DispatchQueue.main.async {
            self.blurView.removeFromSuperview()
            self.activityIndicator.stopAnimating()
        }
    }
}
