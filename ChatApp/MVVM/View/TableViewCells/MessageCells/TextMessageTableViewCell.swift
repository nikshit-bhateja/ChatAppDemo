//
//  TextMessageTableViewCell.swift
//  ChatApp
//
//  Created by Nikk Bhateja on 26/03/25.
//

import UIKit

class TextMessageTableViewCell: UITableViewCell {
    
    //MARK: @IBOutlets
    // UIView
    @IBOutlet weak var bgMainView: UIView!
    
    // UILabel
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    // UIImageView
    @IBOutlet weak var messageDeliverStatusImageView: UIImageView!
    
    
    // Constraints
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override class func description() -> String {
        "TextMessageTableViewCell"
    }
    
    func setupCellUI() {
        
        bgMainView.layer.cornerRadius = 8
        
        // manage background color
        self.bgMainView.backgroundColor = UIColor.white
        
        // manage message text color
        self.messageLabel.textColor = .appGreen
        
        // manage left space color
        
        self.leadingConstraint.constant = 50
        self.trailingConstraint.constant = 8
        
        
        //        if(!isSenderMessage) {
        self.bgMainView.layer.shadowColor = UIColor.black.cgColor
        self.bgMainView.layer.shadowOpacity = 0.2
        self.bgMainView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        //        }
    }
    
    func setMessageData(message: MessageModel) {
        
        self.messageLabel.text = message.text ?? ""
    }
}
