//
//  answerTableViewCell.swift
//  Firebase-DiaryApp
//
//  Created by 近藤米功 on 2022/07/08.
//

import UIKit

class answerTableViewCell: UITableViewCell {

    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var userNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
