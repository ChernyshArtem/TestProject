//
//  ProfileView.swift
//  DetectorEventsViewer
//
//  Created by Артём Черныш on 13.12.23.
//

import UIKit

class ProfileView: UIViewController {
    
    private let userImage: UIImageView = {
        let userImage = UIImageView()
        userImage.image = UIImage(systemName: "person.circle.fill")
        userImage.tintColor = .gray
        return userImage
    }()
    
    private let userName: UILabel = {
        let label = UILabel()
        label.text = UserDefaults.standard.string(forKey: "name")
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private let exitFromAccountButton: UIButton = {
        let exitFromAccount = UIButton(type: .system)
        exitFromAccount.setTitle("exit", for: .normal)
        exitFromAccount.setTitleColor(.white, for: .normal)
        exitFromAccount.backgroundColor = .red
        exitFromAccount.layer.cornerRadius = 15
        return exitFromAccount
    }()
    
    private lazy var screenWidth = view.frame.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubviews()
        setupTargets()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(userImage)
        view.addSubview(userName)
        view.addSubview(exitFromAccountButton)
    }

    private func setupSubviews() {
        userImage.snp.makeConstraints { make in
            make.height.width.equalTo(100)
            make.top.left.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        userName.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.left.equalTo(userImage.snp.right).offset(16)
        }
        exitFromAccountButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(screenWidth-60)
        }
    }
    
    private func setupTargets() {
        exitFromAccountButton.addTarget(self, action: #selector(exitFromAccount), for: .touchUpInside)
    }
    
    @objc
    private func exitFromAccount() {
        UserDefaults.standard.set(nil, forKey: "name")
        view.window?.rootViewController = AuthView()
    }
}
