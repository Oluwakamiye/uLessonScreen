//
//  ViewController.swift
//  uLesson
//
//  Created by Oluwakamiye Akindele on 04/03/2021.
//

import UIKit
import AVKit

class HomeViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var response : ULessonResponseObject?
    var videoThumbNails: VideoThumbNailList?
    
    var numberOfDisplayedVideos: Int = 0
    var isShowingAllVideos: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .clear
        collectionView.backgroundColor = .clear
        // Do any additional setup after loading the view.
        loadResponseObject()
        setNumberOfDisplayedVideos()
        
        tableView.register(UINib(nibName: "VideoItemTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoItemTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeToSubjectDetailsSegue"{
            guard
                let selectedCell = sender as? SubjectCollectionViewCell,
                let selectedRowIndex = collectionView.indexPath(for: selectedCell)?.row
            else {return }
            
            if let subjectDetailsViewController = segue.destination as? SubjectDetailsViewController{
                subjectDetailsViewController.subject = response?.courses.subjects[selectedRowIndex]
                let backItem = UIBarButtonItem()
                backItem.title = response?.courses.subjects[selectedRowIndex].name
                
                navigationItem.backBarButtonItem = backItem
            }
        }
    }

    func loadResponseObject(){
        response = loadJSONFromFileToObject("Resource.json")
        videoThumbNails = loadJSONFromFileToObject("VideoResource.json")
    }
    
    @IBAction func seeMoreVideos(_ sender: UIButton){
        setNumberOfDisplayedVideos()
        sender.imageView?.image = isShowingAllVideos ? UIImage(named: "HomeButtonImage2") : UIImage(named: "HomeButtonImage")
        tableView.reloadData()
        collectionView.reloadData()
    }
    
    func setNumberOfDisplayedVideos(){
        if let videoThumbNails = self.videoThumbNails{
            if isShowingAllVideos{
                numberOfDisplayedVideos = videoThumbNails.data.count
            } else {
                numberOfDisplayedVideos = 2
            }
        } else {
            numberOfDisplayedVideos = 0
        }
        isShowingAllVideos.toggle()
    }
    
    func navigateToVideoController(_ url: String, isAutoPlay: Bool){
        guard let url = URL(string: url) else {
            return
        }
        // Create an AVPlayer, pass it the HTTP Live Streaming URL.
        let player = AVPlayer(url: url)

        // Create a new AVPlayerViewController and pass it a reference to the player.
        let controller = AVPlayerViewController()
        controller.player = player
        
        //display videoPlayer
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true) {
            if isAutoPlay {
                player.play()
            }
        }
    }
}


// MARK:- CollectionView Implementation
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let response = response {
            return response.courses.subjects.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubjectCollectionViewCell", for: indexPath) as! SubjectCollectionViewCell
        let currentSubject = response?.courses.subjects[indexPath.row]
        
        cell.cellLabel.text = currentSubject!.name.uppercased()
        cell.cellLabel.textColor = UIColor.white
        cell.cellLabel.font = UIFont(name: "Mulish", size: 12)
        cell.cellImage.image = UIImage(named: "Icon_\(currentSubject!.name.capitalized)")
        cell.cellbackground.layer.cornerRadius = 13
        cell.cellbackground.backgroundColor = subjectColorDictionary[currentSubject!.name.capitalized]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameWidth = collectionView.frame.width / 2
        return CGSize(width: frameWidth -  5, height: 80)
    }
}


// MARK:- TableView Implementation
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfDisplayedVideos
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoItemTableViewCell", for: indexPath) as! VideoItemTableViewCell
        let videoThumbNailItem = videoThumbNails?.data[indexPath.row]
        
        cell.videoImage.image = UIImage(named: videoThumbNailItem?.imageName ?? "video_thumbnail_4")
        cell.videoImage.layer.cornerRadius = 11
        cell.subjectLabel.text = videoThumbNailItem?.subject
        cell.subjectLabel.font = UIFont(name: "Mulish", size: 12)
        cell.subjectLabel.textColor = subjectColorDictionary[videoThumbNailItem!.subject.capitalized]
        cell.topicLabel.text = videoThumbNailItem?.topic
        cell.topicLabel.font = UIFont(name: "Mulish", size: 15)
        cell.cellBackgroundColor.backgroundColor = .clear
        cell.playButton.tintColor = subjectColorDictionary[videoThumbNailItem!.subject.capitalized]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;
    }
}
