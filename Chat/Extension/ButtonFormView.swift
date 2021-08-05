//
//  ButtonFormView.swift
//  Chat
//
//  Created by Владислав Шушпанов on 27.04.2021.
//

import UIKit

class ButtonFormView: UIView {
    
    init(lable: UILabel, button: UIButton) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        lable.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        
        
        self.addSubview(lable)
        self.addSubview(button)
        
        NSLayoutConstraint.activate([
            lable.topAnchor.constraint(equalTo: self.topAnchor),
            lable.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: lable.bottomAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        bottomAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
