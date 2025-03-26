//
//  UserTableViewCell.swift
//  ChatApp
//
//  Created by Nikk Bhateja on 26/03/25.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    //MARK: @IBOutlets
    // UIImageView
    @IBOutlet weak var userImageView: UIImageView!
    
    // UILabel
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var recentMessageLabel: UILabel!
    @IBOutlet weak var timeAndDateLabel: UILabel!
    @IBOutlet weak var messageCountLabel: UILabel!
    
    // UIView
    @IBOutlet weak var mainBGView: UIView!
    
    //MARK: Cell life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("Cell called...")
    }
    
    //MARK: Custom Methods
    override class func description() -> String {
        return "UserTableViewCell"
    }
    
    func setupCellUI(){
        self.userImageView.layer.cornerRadius = self.userImageView.frame.height / 2
        self.messageCountLabel.layer.cornerRadius = 15
    }
}
