//
//  SubjectViewController.swift
//  uLesson
//
//  Created by Oluwakamiye Akindele on 04/03/2021.
//

import UIKit
import AVKit

class SubjectDetailsViewController: UIViewController {
    @IBOutlet weak var mainStackView: UIStackView!
    var subject: Subject?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.directionalLayoutMargins =
            NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 0)
        if let subject = subject {
            for chapter in subject.chapters {
                addSubjectChapterView(chapter: chapter)
            }
        }
    }
    func navigateToVideoController(_ url: String, isAutoPlay: Bool = true) {
        guard let url = URL(string: url) else {
            return
        }
        // Create an AVPlayer, pass it the HTTP Live Streaming URL.
        let player = AVPlayer(url: url)
        // Create a new AVPlayerViewController and pass it a reference to the player.
        let controller = AVPlayerViewController()
        controller.player = player
        // display videoPlayer
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true) {
            if isAutoPlay {
                player.play()
            }
        }
    }
    func addSubjectChapterView(chapter: Chapter) {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont(name: "Itim", size: 24)
        descriptionLabel.text  = chapter.name
        descriptionLabel.textAlignment = .left
// descriptionLabel.widthAnchor.constraint(equalToConstant: self.mainStackView.frame.width).isActive = true
// descriptionLabel.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        let horizontalLessonStack = UIStackView()
        horizontalLessonStack.axis = .horizontal
        horizontalLessonStack.distribution = .fillEqually
        horizontalLessonStack.spacing = 12
        for lesson in chapter.lessons {
            horizontalLessonStack.addArrangedSubview(
                returnAllLessonsInAChapterView(lesson: lesson))
        }
        let verticalTopicStack = UIStackView()
        verticalTopicStack.axis = .vertical
        verticalTopicStack.distribution = .fill
        verticalTopicStack.alignment = .leading
        verticalTopicStack.spacing = 7
        verticalTopicStack.addArrangedSubview(descriptionLabel)
        verticalTopicStack.addArrangedSubview(horizontalLessonStack)
        mainStackView.addArrangedSubview(verticalTopicStack)
    }
    func returnAllLessonsInAChapterView(lesson: Lesson) -> UIStackView {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        if let lessonThumbNail = URL(string: lesson.icon) {
            imageView.load(url: lessonThumbNail, defaultImageName: "arrow.triangle.2.circlepath.circle")
        } else {
            imageView.image = UIImage(systemName: "arrow.triangle.2.circlepath.circle")
            imageView.backgroundColor = .gray
            imageView.tintColor = .white
            imageView.contentMode = .scaleAspectFit
        }
        // Text Label
        let textLabel = UILabel()
        textLabel.font = UIFont(name: "Mulish", size: 14)
        textLabel.widthAnchor.constraint(equalToConstant: 110).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        textLabel.text  = lesson.name
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 2
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.alignment = .center
        verticalStack.spacing = 12
        verticalStack.addArrangedSubview(imageView)
        verticalStack.addArrangedSubview(textLabel)
        verticalStack.isLayoutMarginsRelativeArrangement = true
        verticalStack.directionalLayoutMargins =
            NSDirectionalEdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10)
        verticalStack.backgroundColor = UIColor.white
        verticalStack.layer.cornerRadius = 9
        verticalStack.tag = lesson.id
        var tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                action: #selector(self.onCellTapped(_:)))
        verticalStack.gestureRecognizers = [ tapGestureRecognizer ]
        return verticalStack
    }
    @IBAction func onCellTapped(_ sender: UITapGestureRecognizer?) {
        if let tag = sender?.view?.tag, let subject = subject {
            guard let selectedChapter = subject.chapters.first(where: { $0.lessons.contains(where: { lesson in return lesson.id ==  tag})})
            else {
                return
            }
            guard let lesson = selectedChapter.lessons.first(where: { lesson in
                                                                return  lesson.id ==  tag})
            else {
                return
            }
            self.navigateToVideoController(lesson.mediaURL)
        }
    }
}
