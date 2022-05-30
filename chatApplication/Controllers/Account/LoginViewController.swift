//
//  LoginViewController.swift
//  chatApplication
//
//  Created by vivek shrivastwa on 27/05/22.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: - outlets
    private let logoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private let emailTF: UITextField = {
       let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.layer.cornerRadius = Constanst.cornerRadius
        textField.layer.borderWidth = Constanst.borderWidth
        textField.layer.borderColor = Constanst.borderColor.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter Email ID....",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
        )
        return textField
    }()
    
    private let passwordTF: UITextField = {
       let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.layer.cornerRadius = Constanst.cornerRadius
        textField.layer.borderWidth = Constanst.borderWidth
        textField.layer.borderColor = Constanst.borderColor.cgColor
        textField.isSecureTextEntry = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter Password....",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
        )
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .link
        button.layer.cornerRadius = Constanst.cornerRadius
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    private let forgetPassworrButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forget Password", for: .normal)
        button.setTitleColor(UIColor.link, for: .normal)
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        return button
    }()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Log In"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(registerButtonTapped))
        
        //add subview
        addingSubviews()
        
        //add targets
        addingTargets()
        
        emailTF.delegate = self
        passwordTF.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //add frame
        let size = view.width / 3
        //frame for logo imageview
        logoImageView.frame = CGRect(x: (view.width - size) / 2, y: 150, width: size, height: size)
        //frame for email textField
        emailTF.frame = CGRect(x: 25, y: logoImageView.bottom + 50, width: view.width - 50, height: 45)
        //frame for password textField
        passwordTF.frame = CGRect(x: 25, y: emailTF.bottom + 20, width: view.width - 50, height: 45)
        //frame for login button
        loginButton.frame = CGRect(x: 25, y: passwordTF.bottom + 40, width: view.width - 50, height: 45)
        //frame for forgotPassword button
        forgetPassworrButton.frame = CGRect(x: view.width - 175, y: loginButton.bottom + 5, width: 150, height: 25)
    }
    
    //MARK: - function
    @objc func registerButtonTapped() {
        print("registre button tappped")
        let registerVC = RegisterViewController()
        registerVC.title = "Create Account"
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    //func for login button tapped
    @objc func didTappedLoginButton() {
        
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        
        guard let email = emailTF.text, !email.isEmpty, email.contains("@"), email.contains("."),
              let password = passwordTF.text, !password.isEmpty, password.count >= 6 else {
            //show error popup
            passwordTF.text = ""
            self.alertForLoginError()
            return
              }
        
        //firebase login
        FirebaseManager.shared.login(email: email, password: password) { result in
            switch result {
            case .success(let isLogin):
                if isLogin{
                    //user creation success show login page
                    print("user login success")
                }
                else {
                    //user creation failed show error message
                    print("user login failed")
                }
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    func alertForLoginError(){
        let alert = UIAlertController(title: "Error Message!", message: "Either Email or Password is incorrent.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    //function to add subviews to uiview
    func addingSubviews() {
        view.addSubview(logoImageView)
        view.addSubview(emailTF)
        view.addSubview(passwordTF)
        view.addSubview(loginButton)
        view.addSubview(forgetPassworrButton)
    }
    
    func addingTargets() {
        loginButton.addTarget(self, action: #selector(didTappedLoginButton), for: .touchUpInside)
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTF{
            emailTF.resignFirstResponder()
            passwordTF.becomeFirstResponder()
        }
        else if textField == passwordTF{
            passwordTF.resignFirstResponder()
            didTappedLoginButton()
        }
        return true
    }
}
