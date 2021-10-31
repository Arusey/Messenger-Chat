//
//  ViewController.swift
//  Messenger
//
//  Created by Kevin Lagat on 27/10/2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var loginWithFacebookBtn: UIButton!
    @IBOutlet weak var loginWithGoogleBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginUser(_ sender: Any) {
       
        guard let userEmail = email.text else { return }
        guard let userPassword = password.text else { return }
        
        
        FirebaseAuth.Auth.auth().signIn(withEmail: userEmail, password: userPassword) { authResult, error in
            
            guard let result = authResult, error == nil else {
                    print("Failed to log in user with email \(userEmail)")
                    return
                }
                let user = result.user
                print("logged in user: \(user)")
            
        }
        
    }
    
    @IBAction func goToRegister(_ sender: Any) {
        let registerVC = storyboard?.instantiateViewController(withIdentifier: "registerVC") as! RegistrationViewController
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
}

