//
//  SetupProfileViewController.swift
//  Chat
//
//  Created by Владислав Шушпанов on 12.05.2021.
//

import UIKit
import FirebaseAuth
import SDWebImage

class SetupProfileViewController: UIViewController {
    
    let welcomeLable = UILabel(text: "Настройка профиля", font: .avenir26())
    
    
    let fullNameLable = UILabel(text: "Имя")
    let aboutMeLable = UILabel(text: "Обо мне")
    let sexLable = UILabel(text: "пол")
    
    let fullNameTextField = OneLineTextField(font: .avenir20())
    let aboutMeTextField = OneLineTextField(font: .avenir20())
    let sexSegmentedControl = UISegmentedControl(first: "Мужчина", second: "Женщина")
    
    let goToChatsButton = UIButton(title: "Начать чат!", backgroundColor: .buttonBlack(), titleColor: .white, cornerRadius: 4)
    
    let fullImageView = AddPhotoView()

    
    private let currentUser: User

    init(currentUser: User) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
        
        if let username = currentUser.displayName {
            fullNameTextField.text = username
        }
        if let photoURL = currentUser.photoURL {
            fullImageView.circleImageView.sd_setImage(with: photoURL, completed: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstrains()
        goToChatsButton.addTarget(self, action: #selector(goToChatsButtonTapped), for: .touchUpInside)
        fullImageView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        
    }
    
    @objc private func plusButtonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc private func goToChatsButtonTapped() {
        FireStoreServices.shared.saveProfileWith(id: currentUser.uid,
                                                 email: currentUser.email!,
                                                 username: fullNameTextField.text,
                                                 avatarImage: fullImageView.circleImageView.image,
                                                 description: aboutMeTextField.text,
                                                 sex: sexSegmentedControl.titleForSegment(at: sexSegmentedControl.selectedSegmentIndex)) { (result) in
                                                     switch result {
                                                         
                                                     case .success(let muser):
                                                        self.showAlert(with: "Успешно!", and: "Данные сохранены!", completion: {
                                                            let mainTabBar = MainTabBarController(currentUser: muser)
                                                            mainTabBar.modalPresentationStyle = .fullScreen
                                                            self.present(mainTabBar, animated: true, completion: nil)
                                                        })
                                                     case .failure(let error):
                                                         self.showAlert(with: "Ошибка!", and: error.localizedDescription)
                                                     }
                                             }
        
        
    }
    
}

extension SetupProfileViewController {
    private func setupConstrains() {
        
        let fullNameStackView = UIStackView(arrangedSubviews: [fullNameLable, fullNameTextField], axis: .vertical, spacing: 0)
        let aboutMeStackView = UIStackView(arrangedSubviews: [aboutMeLable, aboutMeTextField], axis: .vertical, spacing: 0)
        let SexStackView = UIStackView(arrangedSubviews: [sexLable, sexSegmentedControl], axis: .vertical, spacing: 10)
        
        goToChatsButton.heightAnchor.constraint(equalToConstant: 60).isActive = true

        let stackView = UIStackView(arrangedSubviews: [
            fullNameStackView,
            aboutMeStackView,
            SexStackView,
            goToChatsButton
            ], axis: .vertical, spacing: 40)
        
        welcomeLable.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        fullImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLable)
        view.addSubview(fullImageView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            welcomeLable.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            welcomeLable.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            fullImageView.topAnchor.constraint(equalTo: welcomeLable.bottomAnchor, constant: 40),
            fullImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: fullImageView.bottomAnchor,constant: 60),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

// MARK: - UIImagePickerControllerDelegate
extension SetupProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        fullImageView.circleImageView.image = image
    }
}

// MARK: - SwiftUI

import SwiftUI

struct SetupProfileVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let SetupProfileVC = SetupProfileViewController(currentUser: Auth.auth().currentUser!)
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return SetupProfileVC
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
