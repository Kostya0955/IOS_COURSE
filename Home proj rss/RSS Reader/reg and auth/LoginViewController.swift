//
//  LoginViewController.swift
//  RSS Reader
//
//  Created by Константин Головнев on 13/12/2018.
//  Copyright © 2018 Константин Головнев. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let backgroundImage = UIImageView()
    let loginImage = UIImageView()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    let signUpButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBGImage()
        setupLoginImage()
        setupEmail()
        setupPassword()
        setupLoginButton()
        setupSignUpButton()
    }
    
    @objc func loginButtonPressed() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
            } else {
                guard let userID = result?.user.uid else { return }
                print("User: \(userID) signed in")
                defaults.set(true, forKey: authKey)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func sighUpPressed() {
        let sighUpVC = SignUpViewController()
        present(sighUpVC, animated: true, completion: nil)
    }
}
