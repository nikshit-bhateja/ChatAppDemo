//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Nikk Bhateja on 25/03/25.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: @IBOutlets
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log In"
        view.backgroundColor = .white
        
        addRegisterButton()
    }
    
    //MARK: Custom Methods
    private func addRegisterButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.appGreen
    }
    
    @objc private func didTapRegister() {
        guard let registerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController else { return }
        registerVC.title = "Create Account"
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    //MARK: @IBAction
    @IBAction func didTapLoginButton(_ sender: Any) {
        guard let conversationsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ConversationsListingViewController") as? ConversationsListingViewController else{ return }
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "isLoggedIn")
        self.dismiss(animated: true)
    }

}
