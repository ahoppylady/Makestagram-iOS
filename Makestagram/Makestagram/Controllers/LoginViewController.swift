//
//  LoginViewController.swift
//  Makestagram
//
//  Created by Sneha Pankaj on 7/9/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import Foundation
import UIKit
import FirebaseUI
import FirebaseAuth
import FirebaseDatabase

typealias FIRUser = FirebaseAuth.User
class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        // 1 access the FUIAuth default auth UI singleton
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        
        // 2 set FUIAuth's singleton delegate
        authUI.delegate = self
        
        // 3 present the auth view controller
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
}
extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?)  {
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
            return
        }
        
//New code
       guard let user = user else {return}
        UserService.show(forUID: user.uid) { (user) in
            if let user = user {
                // handle existing user
                User.setCurrent(user, writeToUserDefaults: true)
                let initialViewController = UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
//                let storyboard = UIStoryboard(name: "Main", bundle: .main)
//                if let initialViewController = storyboard.instantiateInitialViewController() {
//                    self.view.window?.rootViewController = initialViewController
//                    self.view.window?.makeKeyAndVisible()
//                }
            } else {
                // handle new user
                self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
            }
        }
        
//        // 1
//        guard let user = user
//            else { return }
//        // 2
//        let userRef = Database.database().reference().child("users").child(user.uid)
//        // 3
//        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
//            // 4 retrieve user data from snapshot
//                // 1
//            if let user = User(snapshot: snapshot) {
//                print("Welcome back, \(user.username).")
//            } else {
//                self.performSegue(withIdentifier: "toCreateUsername", sender: self)
//            }
//        })
//        userRef.observeSingleEvent(of: .value, with: { [unowned self] (snapshot) in
//            if let _ = User(snapshot: snapshot) {
//                let storyboard = UIStoryboard(name: "Main", bundle: .main)
//
//                if let initialViewController = storyboard.instantiateInitialViewController() {
//                    self.view.window?.rootViewController = initialViewController
//                    self.view.window?.makeKeyAndVisible()
//                }
//            } else {
//                self.performSegue(withIdentifier: "toCreateUsername", sender: self)
//            }
//        })
//        userRef.observeSingleEvent(of: .value, with: { [unowned self] (snapshot) in
//            if let user = User(snapshot: snapshot) {
//                User.setCurrent(user)
//
//                let storyboard = UIStoryboard(name: "Main", bundle: .main)
//                if let initialViewController = storyboard.instantiateInitialViewController() {
//                    self.view.window?.rootViewController = initialViewController
//                    self.view.window?.makeKeyAndVisible()
//                }
//            } else {
//                self.performSegue(withIdentifier: "toCreateUsername", sender: self)
//            }
//        })

    }
}
