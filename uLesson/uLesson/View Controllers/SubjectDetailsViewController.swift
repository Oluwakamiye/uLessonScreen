//
//  SubjectViewController.swift
//  uLesson
//
//  Created by Oluwakamiye Akindele on 04/03/2021.
//

import UIKit

class SubjectDetailsViewController: UIViewController {
    
    @IBOutlet weak var mainStackView: UIStackView!
    var subject: Subject?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let subject = subject{
            for chapter in subject.chapters{
                addSubjectChapterView(chapter: chapter)
            }
        }
        
    }
    
    func addSubjectChapterView(chapter: Chapter){
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.backgroundColor = .brown
        verticalStack.distribution = .fill
        verticalStack.alignment = .leading
            
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont(name: "Itim", size: 24)
        descriptionLabel.text  = chapter.name
        descriptionLabel.textAlignment = .left
//        descriptionLabel.widthAnchor.constraint(equalToConstant: self.mainStackView.frame.width).isActive = true
//        descriptionLabel.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        let horizontalLessonStack = UIStackView()
        horizontalLessonStack.axis = .horizontal
        horizontalLessonStack.distribution = .fillEqually
        horizontalLessonStack.spacing = 12
            
        for lesson in chapter.lessons{
            horizontalLessonStack.addArrangedSubview(returnLessonView(lesson: lesson))
        }
         
        verticalStack.addArrangedSubview(descriptionLabel)
        verticalStack.addArrangedSubview(horizontalLessonStack)
        
        mainStackView.addArrangedSubview(verticalStack)
        
    }
    
    func returnLessonView(lesson: Lesson) -> UIStackView{
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        imageView.image = UIImage(named: "video_thumbnail_1")
        

        //Text Label
        let textLabel = UILabel()
        textLabel.backgroundColor = UIColor.yellow
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
        verticalStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        verticalStack.backgroundColor = UIColor.white
        verticalStack.layer.cornerRadius = 15
        
        let screenSize: CGRect = UIScreen.main.bounds
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width - 10, height: 10))

//        let view = UIView()
        view.addSubview(verticalStack)
        return verticalStack
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
