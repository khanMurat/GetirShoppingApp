//
//  UIColorExtension.swift
//  GetirFinalCase
//
//  Created by Murat on 9.04.2024.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(hexString: String) {
        
        var hexColor: String = hexString.removeWhiteSpace.uppercased()
        
        if (hexColor.hasPrefix("#")) {
            hexColor.remove(at: hexColor.startIndex)
        }
        
        if ((hexColor.count) != 6) {
            self.init(
                red: 0 / 255.0,
                green: 0 / 255.0,
                blue: 0 / 255.0,
                alpha: 1
            )
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexColor).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}



extension UIColor {
    
    static var color_purple: UIColor {
        return UIColor(hexString: "#5940b5")
    }
    
    static var color_lightGray: UIColor {
        return UIColor(hexString: "#F2F0FA")
    }
    
    static var color_secondaryText : UIColor {
        return UIColor(hexString: "#697488")
    }
}
