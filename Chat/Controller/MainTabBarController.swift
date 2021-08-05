//
//  MainTabBarController.swift
//  Chat
//
//  Created by Владислав Шушпанов on 12.05.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private let currentUser: MUser
    
    init(currentUser: MUser = MUser(username: "qwe", email: "qwe", avatarStringURL: "qwe", description: "qwe", sex: "qwe", id: "qwe")) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listViewController = ListViewController(currentUser: currentUser)
        let peopleViewController = PeopleViewController(currentUser: currentUser)
        
        tabBar.tintColor = .purple
        let boldConfig = UIImage.SymbolConfiguration(weight: .medium)
        let convImage = UIImage(systemName: "bubble.left.and.bubble.right", withConfiguration: boldConfig)!
        let peopleImage = UIImage(systemName: "person.2", withConfiguration: boldConfig)!
        viewControllers = [
            generateNavigationController(rootViewController: peopleViewController, title: "Люди", image: peopleImage),
            generateNavigationController(rootViewController: listViewController, title: "Беседы", image: convImage)
        ]
    }
     
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage)-> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC

    }
        
    
}
