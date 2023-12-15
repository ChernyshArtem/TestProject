//
//  AuthView.swift
//  DetectorEventsViewer
//
//  Created by Артём Черныш on 13.12.23.
//

import UIKit
import SnapKit

class AuthView: UIViewController {
    
    private let nameField: UITextField = {
        let userNameField = UITextField()
        userNameField.placeholder = " nickname"
        userNameField.layer.cornerRadius = 10
        userNameField.layer.borderColor = UIColor.gray.cgColor
        userNameField.layer.borderWidth = 1
        userNameField.autocapitalizationType = .none
        return userNameField
    }()
    
    private let passwordField: UITextField = {
        let passwordField = UITextField()
        passwordField.placeholder = " password"
        passwordField.layer.cornerRadius = 10
        passwordField.layer.borderColor = UIColor.gray.cgColor
        passwordField.layer.borderWidth = 1
        passwordField.autocapitalizationType = .none
        passwordField.isSecureTextEntry = true
        return passwordField
    }()
    
    private let loginButton: UIButton = {
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .systemBlue
        loginButton.layer.cornerRadius = 18
        return loginButton
    }()
    
    private lazy var screenWidth = view.frame.width
    private let viewModel: AuthViewModelInterface = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubviews()
        setupTargets()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(nameField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
    }
    
    private func setupSubviews() {
        nameField.snp.makeConstraints { make in
            make.bottom.equalTo(passwordField.snp.top).inset(-16)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
            make.width.equalTo(screenWidth-60)
        }
        passwordField.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
            make.width.equalTo(screenWidth-60)
        }
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(16)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
            make.width.equalTo(screenWidth-60)
        }
    }
    
    private func setupTargets() {
        loginButton.addTarget(self, action: #selector(checkUserLogin), for: .touchUpInside)
    }
    
    @objc
    private func checkUserLogin() {
        guard let name = nameField.text,
              let password = passwordField.text
        else { return }
        viewModel.checkUserLogin(name: name, password: password) { [weak self] success in
            if success {
                self?.view.window?.rootViewController = DetectorTabBar()
            }
        }
    }
    
}
