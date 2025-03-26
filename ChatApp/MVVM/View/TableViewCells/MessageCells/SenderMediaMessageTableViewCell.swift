//
//  SenderMediaMessageTableViewCell.swift
//  ChatApp
//
//  Created by Nikk Bhateja on 26/03/25.
//

import UIKit

class SenderMediaMessageTableViewCell: UITableViewCell {

    //MARK: @IBOutlets
    @IBOutlet weak var bgMainView: UIView!
    
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var messageDeliverStatus: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override class func description() -> String {
        "SenderMediaMessageTableViewCell"
    }
    
    func setUI() {
        self.bgMainView.layer.cornerRadius = 10
        self.bgMainView.backgroundColor = .red
    }
    
    func setMedia(message: MessageModel) {
        self.mediaImageView.image = UIImage(contentsOfFile: message.image ?? "")
    }
    
}
