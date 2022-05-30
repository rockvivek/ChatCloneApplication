//
//  ViewController.swift
//  chatApplication
//
//  Created by vivek shrivastwa on 27/05/22.
//

import UIKit

class ConversationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let isLoggIn = UserDefaults.standard.bool(forKey: "loggedIn")
        if !isLoggIn {
            //user is not login
            let loginVC = LoginViewController()
            let navVC = UINavigationController(rootViewController: loginVC)
            navVC.modalPresentationStyle = .fullScreen
            present(navVC, animated: false)

        }
        
    }

}

