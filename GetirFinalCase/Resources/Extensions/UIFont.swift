//
//  UIFont.swift
//  GetirFinalCase
//
//  Created by Murat on 14.04.2024.
//

import Foundation
import UIKit


extension UIFont {
        
    static var sansSemiBold12: UIFont {
        UIFont(name: "OpenSans-SemiBold", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .semibold)
    }
    
    static var sansSemiBold16: UIFont {
        UIFont(name: "OpenSans-SemiBold", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    static var sansBold12: UIFont {
        UIFont(name: "OpenSans-Bold", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .bold)
    }
    
    static var sansBold14: UIFont {
        UIFont(name: "OpenSans-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .bold)
    }
    
    static var sansBold20: UIFont {
        UIFont(name: "OpenSans-Bold", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .bold)
    }
}
