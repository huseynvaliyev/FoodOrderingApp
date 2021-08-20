//
//  SignInViewController.swift
//  FoodOrderingApp
//
//  Created by Huseyn Valiyev on 12.08.2021.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var connectFacebookButton: UIButton!
    @IBOutlet weak var connectGoogleButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        let emailBottomLine = CALayer()
        emailBottomLine.frame = CGRect(x: 0.0, y: emailTextField.frame.height - 1, width: emailTextField.frame.width, height: 1.0)
        emailTextField.borderStyle = UITextField.BorderStyle.none
        emailTextField.layer.addSublayer(emailBottomLine)
        emailBottomLine.backgroundColor = UIColor.systemGray6.cgColor
        
        let passwordBottomLine = CALayer()
        passwordBottomLine.frame = CGRect(x: 0.0, y: passwordTextField.frame.height - 1, width: passwordTextField.frame.width, height: 1.0)
        passwordTextField.borderStyle = UITextField.BorderStyle.none
        passwordTextField.layer.addSublayer(passwordBottomLine)
        passwordBottomLine.backgroundColor = UIColor.systemGray6.cgColor
        
        errorLabel.isHidden = true
        
        signInButton.layer.cornerRadius = 8
        connectFacebookButton.layer.cornerRadius = 8
        connectGoogleButton.layer.cornerRadius = 8
        
        signInButton.clipsToBounds = true
        connectFacebookButton.clipsToBounds = true
        connectGoogleButton.clipsToBounds = true
        
        connectFacebookButton.setImage(#imageLiteral(resourceName: "icon-facebook"), for: .normal)
        connectFacebookButton.tintColor = .white
        connectFacebookButton.imageView?.contentMode = .scaleAspectFit
        connectFacebookButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: -30, bottom: 12, right: 0)
        
        connectGoogleButton.setImage(#imageLiteral(resourceName: "icon-google"), for: .normal)
        connectGoogleButton.tintColor = .white
        connectGoogleButton.imageView?.contentMode = .scaleAspectFit
        connectGoogleButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: -45, bottom: 12, right: 0)
        
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.errorLabel.text = error?.localizedDescription
            }
            let getLocationController = self.storyboard?.instantiateViewController(identifier: "getLocation") as! GetLocationViewController
            self.present(getLocationController, animated: true, completion: nil)
        }
    }
    
    @IBAction func connectWithFacebookTapped(_ sender: Any) {
        
    }
    
    @IBAction func connectWithGoogle(_ sender: Any) {
        
    }
    
}
