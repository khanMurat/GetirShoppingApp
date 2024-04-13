//
//  UIImageViewExtension.swift
//  GetirFinalCase
//
//  Created by Murat on 10.04.2024.
//

import Foundation
import SDWebImage

extension UIImageView {
    func fetchImage(_ urlStr: String?, _ placeholder: UIImage?, _ withActivityIndicator: Bool = true) {
        if let urlStr, !urlStr.isEmpty, let url = URL(string: urlStr) {
            if withActivityIndicator {
                sd_imageIndicator = SDWebImageActivityIndicator.white
            }
            self.sd_setImage(with: url, placeholderImage: placeholder, completed: nil)
        } else {
            image = placeholder
        }
    }

    func fetchImage(_ url: URL?, _ placeholder: UIImage?, _ withActivityIndicator: Bool = true) {
        if let url {
            if withActivityIndicator {
                sd_imageIndicator = SDWebImageActivityIndicator.white
            }
            self.sd_setImage(with: url, placeholderImage: placeholder, completed: nil)
        } else {
            image = placeholder
        }
    }

}
