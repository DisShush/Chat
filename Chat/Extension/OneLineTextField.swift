//
//  OneLineTextField.swift
//  Chat
//
//  Created by Владислав Шушпанов on 10.05.2021.
//

import UIKit


class OneLineTextField: UITextField {
    convenience init(font: UIFont? = .avenir20()) {
        self.init()
        
        self.font = font
        self.borderStyle = .none
        self.translatesAutoresizingMaskIntoConstraints = false
        
        
        var buttonView = UIView()
        buttonView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        buttonView.backgroundColor = .textFieldLight()
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonView)
        
        NSLayoutConstraint.activate([
            buttonView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            buttonView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            buttonView.heightAnchor.constraint(equalToConstant: 1)

        ])
        
    }
}
