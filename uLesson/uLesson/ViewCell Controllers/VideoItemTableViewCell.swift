//
//  VideoItemTableViewCell.swift
//  uLesson
//
//  Created by Oluwakamiye Akindele on 04/03/2021.
//

import UIKit

class VideoItemTableViewCell: UITableViewCell {

    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
