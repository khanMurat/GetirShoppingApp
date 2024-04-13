//
//  StringExtension.swift
//  GetirFinalCase
//
//  Created by Murat on 9.04.2024.
//

import Foundation
import UIKit


extension String {
    
    var _color: UIColor {
        return UIColor.init(named: self) ?? UIColor.init(hexString: self)
    }

    var _colorcg: CGColor {
        return self._color.cgColor
    }

    var _toImage: UIImage? {
        return UIImage.init(named: self)
    }
    
    var removeWhiteSpace: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

