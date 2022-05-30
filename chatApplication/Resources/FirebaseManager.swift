//
//  FirebaseManager.swift
//  chatApplication
//
//  Created by vivek shrivastwa on 30/05/22.
//

import Foundation
import FirebaseAuth


class FirebaseManager: NSObject {
    //MARK: - shared object
    static let shared = FirebaseManager()
    
    //MARK: - public func
    public func createUser(email: String, password: String, firstName: String, lastName: String, completion: @escaping (Result<Bool,Error>) -> Void) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let result = authResult, error == nil else {
                print("failed to create user")
                completion(.failure(error!))
                return
            }
            let user = result.user
            print(user)
            completion(.success(true))
        }
    }
    
    public func login(email: String, password: String, completion: @escaping (Result<Bool,Error>) -> Void) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            guard let result = authResult, error == nil else {
                print("failed to login user")
                completion(.failure(error!))
                return
            }
            let user = result.user
            print(user)
            completion(.success(true))
        }
    }
}
