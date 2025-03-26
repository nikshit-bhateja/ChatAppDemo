//
//  ConversationsListingViewController.swift
//  ChatApp
//
//  Created by Nikk Bhateja on 26/03/25.
//

import UIKit

class ConversationsListingViewController: UIViewController {
    
    //MARK: @IBOutlets
    
    
    // UITableView
    @IBOutlet weak var chatListTableVIew: UITableView!
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Chats"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        regissetrTableViewCell()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkUserLogInStatus()
    }
    
    //MARK: Custom Methods
    func checkUserLogInStatus() {
        let defaults = UserDefaults.standard
        let isLoggedIn = defaults.bool(forKey: "isLoggedIn")
        
        if(!isLoggedIn) {
            guard let rootVC = UIStoryboard(name: "Main",
                                            bundle: nil)
                .instantiateViewController(withIdentifier: "LoginViewController")
                as? LoginViewController else { return }
            
            let navigationController = UINavigationController(rootViewController: rootVC)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: false)
        }
        // fetch chats here
        else{
            
        }
    }
    
    // Register table view cell
    func regissetrTableViewCell() {
        self.chatListTableVIew.delegate = self
        self.chatListTableVIew.dataSource = self
        chatListTableVIew.register(UINib(nibName: UserTableViewCell.description(),
                                         bundle: nil),
                                   forCellReuseIdentifier: UserTableViewCell.description())
    }
}

//MARK: UITableViewDelegate
extension ConversationsListingViewController: UITableViewDelegate {
    
}


//MARK: UITableViewDataSource
extension ConversationsListingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let userCell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.description(),
                                                           for: indexPath) as?  UserTableViewCell else {
            return UITableViewCell()
        }
        userCell.setupCellUI()
        return userCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let conversationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ConversationViewController") as? ConversationViewController else{ return }
        self.navigationController?.pushViewController(conversationVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
