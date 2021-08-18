//
//  SignUpViewController.swift
//  FoodOrderingApp
//
//  Created by Huseyn Valiyev on 14.08.2021.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var connectFacebookButton: UIButton!
    @IBOutlet weak var connectGoogleButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        let nameBottomLine = CALayer()
        nameBottomLine.frame = CGRect(x: 0.0, y: nameTextField.frame.height - 1, width: nameTextField.frame.width, height: 1.0)
        nameTextField.borderStyle = UITextField.BorderStyle.none
        nameTextField.layer.addSublayer(nameBottomLine)
        nameBottomLine.backgroundColor = UIColor.systemGray6.cgColor
        
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
        
        signUpButton.layer.cornerRadius = 8
        connectFacebookButton.layer.cornerRadius = 8
        connectGoogleButton.layer.cornerRadius = 8
        
        signUpButton.clipsToBounds = true
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
    
    private func validateFields() -> String? {
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please enter your full name."
        } else if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please enter email."
        } else if passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please enter password."
        }
        return nil
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        let errorText =  validateFields()
        if errorText != nil {
            errorLabel.text = errorText
            errorLabel.isHidden = false
        } else {
            guard let fullname = nameTextField.text else { return }
            guard let email = emailTextField.text else { return }
            guard let password = passwordTextField.text else { return }
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    self.errorLabel.text = error?.localizedDescription
                } else {
                    guard let result = result else { return }
                    let db = Firestore.firestore()
                    let defaults = UserDefaults.standard
                    defaults.setValue(result.user.uid, forKey: "userId")
                    db.collection("users").document(result.user.uid).setData(["fullname": fullname, "email": email, "id": result.user.uid, "location": ""]) { err in
                        if err != nil {
                            self.errorLabel.text = "Error happening saving user data."
                        }
                    }
                    self.performSegue(withIdentifier: "signUpToSignIn", sender: self)
                }
            }
        }
        
    }
    
    @IBAction func connectFacebookButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func connectGoogleButtonTapped(_ sender: Any) {
        
    }
    
    
}
