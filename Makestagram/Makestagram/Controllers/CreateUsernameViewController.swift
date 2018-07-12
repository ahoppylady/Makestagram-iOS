//
//  CreateUsernameViewController.swift
//  Makestagram
//
//  Created by Sneha Pankaj on 7/10/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
class CreateUsernameViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let firUser = Auth.auth().currentUser,
            let username = usernameTextField.text,
            !username.isEmpty else { return }
        
//        UserService.create(firUser, username: username) { (user) in
//            guard let user = user else { return }
//
//            print("Created new user: \(user.username)")
//        }
//        UserService.create(firUser, username: username) { (user) in
//            guard let _ = user else {
//                return
//            }
//
//            let storyboard = UIStoryboard(name: "Main", bundle: .main)
//
//            if let initialViewController = storyboard.instantiateInitialViewController() {
//                self.view.window?.rootViewController = initialViewController
//                self.view.window?.makeKeyAndVisible()
//            }
//        }
        UserService.create(firUser, username: username) { (user) in
            guard let user = user else {
                // handle error
                return
            }
           User.setCurrent(user, writeToUserDefaults: true)
            let initialViewController = UIStoryboard.initialViewController(for: .main)
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
//            let storyboard = UIStoryboard(name: "Main", bundle: .main)
//            if let initialViewController = storyboard.instantiateInitialViewController() {
//                self.view.window?.rootViewController = initialViewController
//                self.view.window?.makeKeyAndVisible()
//            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
