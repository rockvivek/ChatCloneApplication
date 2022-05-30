//
//  RegisterViewController.swift
//  chatApplication
//
//  Created by vivek shrivastwa on 27/05/22.
//

import UIKit

enum sourceType: String {
    
    case camera = "camera"
    case photoLibrary = "photoLibaray"
}

class RegisterViewController: UIViewController {
    
    //MARK: - outlets
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        imageView.tintColor = .gray
        return imageView
    }()
    
    private let  firstNameTF: UITextField = {
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
            string: "Enter First Name...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
        )
        return textField
    }()
    
    private let lastNameTF: UITextField = {
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
            string: "Enter Last Name....",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
        )
        return textField
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
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .link
        button.layer.cornerRadius = Constanst.cornerRadius
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
  
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        //add subview
        addingSubviews()
        
        //add targets
        addingTargets()
        
        emailTF.delegate = self
        passwordTF.delegate = self
        
        logoImageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfileImage))
        gesture.numberOfTapsRequired = 1
        logoImageView.addGestureRecognizer(gesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //add frame
        let size = view.width / 3
        //frame for logo imageview
        logoImageView.frame = CGRect(x: (view.width - size) / 2, y: 150, width: size, height: size)
        //frame for firstname textField
        firstNameTF.frame = CGRect(x: 25, y: logoImageView.bottom + 50, width: view.width - 50, height: 45)
        //frame for lastname textField
        lastNameTF.frame = CGRect(x: 25, y: firstNameTF.bottom + 20, width: view.width - 50, height: 45)
        //frame for email textField
        emailTF.frame = CGRect(x: 25, y: lastNameTF.bottom + 20, width: view.width - 50, height: 45)
        //frame for password textField
        passwordTF.frame = CGRect(x: 25, y: emailTF.bottom + 20, width: view.width - 50, height: 45)
        //frame for login button
        registerButton.frame = CGRect(x: 25, y: passwordTF.bottom + 40, width: view.width - 50, height: 45)
    }
    
    //MARK: - function
    
    //func for login button tapped
    @objc func didTappedregisterButton() {
        
        firstNameTF.resignFirstResponder()
        lastNameTF.resignFirstResponder()
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        
        guard let email = emailTF.text, !email.isEmpty, email.contains("@"), email.contains("."),
              let firstname = firstNameTF.text, !firstname.isEmpty,
              let lastname = lastNameTF.text, !lastname.isEmpty,
              let password = passwordTF.text, !password.isEmpty, password.count >= 6 else {
            //show error popup
            passwordTF.text = ""
            self.alertForLoginError()
            return
        }
        //firebase signup
        FirebaseManager.shared.createUser(email: email, password: password, firstName: firstname, lastName: lastname) { result in
            switch result {
            case .success(let isCreated):
                if isCreated{
                    //user creation success show login page
                    print("user creation success")
                }
                else {
                    //user creation failed show error message
                    print("user creation failed")
                }
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    @objc func didTapProfileImage() {
        presentActionSheet()
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
        view.addSubview(registerButton)
        view.addSubview(firstNameTF)
        view.addSubview(lastNameTF)
    }
    
    func addingTargets() {
        registerButton.addTarget(self, action: #selector(didTappedregisterButton), for: .touchUpInside)
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameTF{
            lastNameTF.becomeFirstResponder()
        }
        else if textField == lastNameTF {
            emailTF.becomeFirstResponder()
        }
        else if textField == emailTF{
            passwordTF.becomeFirstResponder()
        }
        else if textField == passwordTF{
            didTappedregisterButton()
        }
        return true
    }
}

extension RegisterViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func presentActionSheet() {
        let action = UIAlertController(title: "Profile Picture", message: "How would you like to slect a profile Picture?", preferredStyle: .actionSheet)
        action.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        action.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            print("take photo")
            self.presentImagePickerController(type: sourceType.camera)
        }))
        action.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
            print("choose photo")
            self.presentImagePickerController(type: sourceType.photoLibrary)
        }))
        present(action, animated: true)
    }
    
    func presentImagePickerController(type: sourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        if type == .camera{
            imagePickerController.sourceType = .camera
        }
        else {
            imagePickerController.sourceType = .photoLibrary
        }
        
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        print("selected image: ",info)
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        logoImageView.image = image
        logoImageView.layer.masksToBounds = true
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.layer.borderWidth = 1
        logoImageView.layer.cornerRadius =  view.width / 6
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancel picker")
        picker.dismiss(animated: true)
    }
}
