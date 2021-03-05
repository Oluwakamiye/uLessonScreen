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
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var playButton: UIButton!
    var tapGestureRecognizer = UITapGestureRecognizer()
    var actionToTake: () -> Void = {}
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onCellTapped(_:)))
        cellBackgroundView.gestureRecognizers = [ tapGestureRecognizer ]
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        playButton.roundCorners(corners: [.topLeft, .bottomRight, .topRight], radius: 14)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onPlayButtonTapped(_ sender: UIButton?) {
        self.actionToTake()
    }
    @IBAction func onCellTapped(_ sender: UITapGestureRecognizer?) {
        self.actionToTake()
    }
}
