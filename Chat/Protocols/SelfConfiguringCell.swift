//
//  SelfConfiguringCell.swift
//  Chat
//
//  Created by Владислав Шушпанов on 13.05.2021.
//

import Foundation

protocol SelfConfiguringCell  {
    static var reuseId: String { get }
    func configure<U: Hashable>(with value: U)
}
