//
//  UIImageView + Extension.swift
//  Chat
//
//  Created by Владислав Шушпанов on 27.04.2021.
//

import Foundation
import UIKit

extension UIImageView {
    convenience init(image: UIImage?, contentMode: UIView.ContentMode){
        self.init()
        
        self.image = image
        self.contentMode = contentMode
    }
}


extension UIImageView {
  func setupColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
