//
//  UILable + Extension.swift
//  Chat
//
//  Created by Владислав Шушпанов on 27.04.2021.
//

import Foundation
import UIKit

extension UILabel {
    
    convenience init(text: String,
                     font: UIFont? = .avenir20()) {
        self.init()
        self.font = font
        self.text = text
    }
}
 
