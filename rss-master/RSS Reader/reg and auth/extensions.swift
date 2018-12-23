//
//  extensions.swift
//  RSS Reader
//
//  Created by Константин Головнев on 13/12/2018.
//  Copyright © 2018 Константин Головнев. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setupTextField(title: String) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(red: 205/255, green: 215/255, blue: 235/255, alpha: 1)
        self.layer.cornerRadius = 5
        self.textColor = .darkGray
        self.font = UIFont.boldSystemFont(ofSize: 18)
        self.placeholder = title
        setLeftPaddingPoints(10)
        setRightPaddingPoints(10)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 40),
            self.widthAnchor.constraint(equalToConstant: 220)
            ])
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UIButton {
    func setupButton(title: String) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor(red: 83/255, green: 140/255, blue: 175/255, alpha: 1).cgColor
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.titleLabel?.textColor = .black
        self.setAttributedTitle(NSAttributedString(string: title), for: .normal)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 40),
            self.widthAnchor.constraint(equalToConstant: 220)
            ])
    }
}


extension LoginViewController {
    
    func setupBGImage() {
        let bgImage = UIImage(named: "bgLogin")
        view.addSubview(backgroundImage)
        backgroundImage.image = bgImage
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
            ])
    }
    
    func setupLoginImage() {
        let logImage = UIImage(named: "loginBGCard")
        view.addSubview(loginImage)
        loginImage.image = logImage
        loginImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            loginImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -self.view.frame.height / 5),
            loginImage.heightAnchor.constraint(equalToConstant: 350),
            loginImage.widthAnchor.constraint(equalToConstant: 320)
            ])
    }
    
    func setupEmail() {
        view.addSubview(emailTextField)
        emailTextField.setupTextField(title: "Email adress:")
        
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            emailTextField.topAnchor.constraint(equalTo: loginImage.topAnchor, constant: 80)
            ])
    }
    
    func setupPassword() {
        view.addSubview(passwordTextField)
        passwordTextField.setupTextField(title: "Password:")
        passwordTextField.isSecureTextEntry = true
        
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            ])
    }
    
    func setupLoginButton() {
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setupButton(title: "LOGIN")
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20)
            ])
    }
    
    func setupSignUpButton() {
        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setupButton(title: "SIGN UP")
        signUpButton.addTarget(self, action: #selector(sighUpPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20)
            ])
    }
}

extension SignUpViewController {
    
    func setupBGImage() {
        let bgImage = UIImage(named: "bgLogin")
        view.addSubview(backgroundImage)
        backgroundImage.image = bgImage
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
            ])
    }
    
    func setupBackgroundCard() {
        let cardImage = UIImage(named: "loginBGCard")
        view.addSubview(backgroundCardImage)
        backgroundCardImage.image = cardImage
        backgroundCardImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundCardImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            backgroundCardImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -self.view.frame.height / 8),
            backgroundCardImage.heightAnchor.constraint(equalToConstant: 500),
            backgroundCardImage.widthAnchor.constraint(equalToConstant: 320)
            ])
    }

    func setupNameTextField() {
        view.addSubview(nameTextField)
        nameTextField.setupTextField(title: "Name:")
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            nameTextField.topAnchor.constraint(equalTo: backgroundCardImage.topAnchor, constant: 100)
            ])
    }

    func setupEmailTextField() {
        view.addSubview(emailTextField)
        emailTextField.setupTextField(title: "Email:")
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20)
            ])
    }

    func setupPasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.setupTextField(title: "Password:")
        passwordTextField.isSecureTextEntry = true
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20)
            ])
    }

    func setupConfirmPasswordTextField() {
        view.addSubview(confirmPasswordTextField)
        confirmPasswordTextField.setupTextField(title: "Confirm Password:")
        confirmPasswordTextField.isSecureTextEntry = true
        NSLayoutConstraint.activate([
            confirmPasswordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20)
            ])
    }

    func setupSubmitButton() {
        view.addSubview(submitButton)
        submitButton.setupButton(title: "Submit")
        NSLayoutConstraint.activate([
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            submitButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 20)
            ])
        submitButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
    }

    func setupCancelButton() {
        view.addSubview(cancelButton)
        cancelButton.setupButton(title: "Cancel")
        NSLayoutConstraint.activate([
            cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            cancelButton.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 20)
            ])
        cancelButton.layer.borderColor = UIColor.red.cgColor
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
    }
}
