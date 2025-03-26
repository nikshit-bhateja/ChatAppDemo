//
//  ReceiverTextMessageTableViewCell.swift
//  ChatApp
//
//  Created by Nikk Bhateja on 26/03/25.
//

import UIKit

class ReceiverTextMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var mainBGView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageDeliverStatus: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override class func description() -> String {
        "ReceiverTextMessageTableViewCell"
    }
    
    func setupCellUI() {
        
        mainBGView.layer.cornerRadius = 8
        
        // manage background color
        self.mainBGView.backgroundColor = .appGreen
        
        // manage message text color
        self.messageLabel.textColor = .white
        
        //        if(!isSenderMessage) {
        self.mainBGView.layer.shadowColor = UIColor.black.cgColor
        self.mainBGView.layer.shadowOpacity = 0.2
        self.mainBGView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        //        }
    }
    
    func setMessageData(message: MessageModel) {
        self.messageLabel.text = message.text ?? ""
    }
    
    
}
