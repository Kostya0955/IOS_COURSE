//
//  SignUpViewController.swift
//  RSS Reader
//
//  Created by Константин Головнев on 13/12/2018.
//  Copyright © 2018 Константин Головнев. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    let backgroundImage = UIImageView()
    let backgroundCardImage = UIImageView()
    let nameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let confirmPasswordTextField = UITextField()
    
    let submitButton = UIButton()
    let cancelButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBGImage()
        setupBackgroundCard()
        setupNameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupConfirmPasswordTextField()
        setupSubmitButton()
        setupCancelButton()
    }
    
    @objc func submitButtonPressed() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
            } else {
                guard let userID = result?.user.uid else { return }
                print("user created successfully: ", userID)
                defaults.set(false, forKey: authKey)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
}
