//
//  WaitingChatsNavigation.swift
//  Chat
//
//  Created by Владислав Шушпанов on 25.05.2021.
//

import Foundation

protocol WaitingChatsNavigation: class {
    func removeWaitingChat(chat: MChat)
    func changeToActive(chat: MChat)
}
