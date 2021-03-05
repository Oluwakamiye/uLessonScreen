//
//  ViewController.swift
//  uLesson
//
//  Created by Oluwakamiye Akindele on 04/03/2021.
//

import UIKit
import AVKit

class HomeViewController: UIViewController {
    // Links to views from storyboard
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var homeBackgroundView: UIView!
    var response: ULessonResponseObject?
    var videoThumbNails: VideoThumbNailList?
    var numberOfDisplayedVideos: Int = 0
    var isShowingAllVideos: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Customise views
        tableView.backgroundColor = .clear
        collectionView.backgroundColor = .clear
        // load data
        loadData()
        setNumberOfDisplayedVideos()
        // register custom TableViewCell
        tableView.register(UINib(nibName: "VideoItemTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "VideoItemTableViewCell")
        // Collection Views datasources and delegates
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    // Segue from Home Screen to Subject Detail Screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeToSubjectDetailsSegue"{
            guard
                let selectedCell = sender as? SubjectCollectionViewCell,
                let selectedRowIndex = collectionView.indexPath(for: selectedCell)?.row
            else {return }
            if let subjectDetailsViewController = segue.destination as? SubjectDetailsViewController {
                subjectDetailsViewController.subject = response?.courses.subjects[selectedRowIndex]
                let backItem = UIBarButtonItem()
                backItem.title = response?.courses.subjects[selectedRowIndex].name
                navigationItem.backBarButtonItem = backItem
            }
        }
    }
    // Load data from hard coded json file, then load from network call
    func loadData() {
        response = loadJSONFromFileToObject("Resource.json")
        videoThumbNails = loadJSONFromFileToObject("VideoResource.json")
        NetworkController.makeGetCall(homeURL, errorHandler: { _ in
                                            DispatchQueue.main.async {
                                                let alert = UIAlertController(title: "Error loading data",
message: "We could not load online data. We will continue with offline data",
preferredStyle: UIAlertController.Style.alert)
                                                alert.addAction(UIAlertAction(title: "Okay", style:
             UIAlertAction.Style.default, handler: nil))
                                                self.present(alert,
                                                             animated: true,
                                                             completion: nil)
                                            }
        }, completionHandler: { response in
            self.processResponseFromNetwork(responseObject: response)
        })
    }
    // Process data from network call
    func processResponseFromNetwork(responseObject: ULessonResponseObject) {
        self.response = responseObject
    }
    // Button action to display more items on the tableview
    @IBAction func seeMoreVideos(_ sender: UIButton) {
        sender.setImage(isShowingAllVideos ? UIImage(named: "HomeButtonImage2") :
                            UIImage(named: "HomeButtonImage"), for: .normal)
        setNumberOfDisplayedVideos()
        tableView.reloadData()
        collectionView.reloadData()
    }
    // Set number of displayed videos
    func setNumberOfDisplayedVideos() {
        if let videoThumbNails = self.videoThumbNails {
            if isShowingAllVideos {
                numberOfDisplayedVideos = videoThumbNails.data.count
            } else {
                numberOfDisplayedVideos = 2
            }
        } else {
            numberOfDisplayedVideos = 0
        }
        isShowingAllVideos.toggle()
    }
    // Navigate to Online video player
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
}

// MARK: - CollectionView Implementation
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let response = response {
            return response.courses.subjects.count
        } else {
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubjectCollectionViewCell",
                                                      for: indexPath) as! SubjectCollectionViewCell
        let currentSubject = response?.courses.subjects[indexPath.row]
        cell.cellLabel.text = currentSubject!.name.uppercased()
        cell.cellLabel.textColor = UIColor.white
        cell.cellLabel.font = UIFont(name: "Mulish", size: 12)
        cell.cellImage.image = UIImage(named: "Icon_\(currentSubject!.name.capitalized)")
        cell.cellbackground.layer.cornerRadius = 13
        cell.cellbackground.backgroundColor = subjectColorDictionary[currentSubject!.name.capitalized]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameWidth = collectionView.frame.width / 2
        return CGSize(width: frameWidth -  5, height: 80)
    }
}

// MARK: - TableView Implementation
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfDisplayedVideos
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoItemTableViewCell",
                                                 for: indexPath) as! VideoItemTableViewCell
        let videoThumbNailItem = videoThumbNails?.data[indexPath.row]
        cell.videoImage.image = UIImage(named: videoThumbNailItem?.imageName ?? "video_thumbnail_4")
        cell.videoImage.layer.cornerRadius = 11
        cell.subjectLabel.text = videoThumbNailItem?.subject
        cell.subjectLabel.font = UIFont(name: "Mulish", size: 12)
        cell.subjectLabel.textColor = subjectColorDictionary[videoThumbNailItem!.subject.capitalized]
        cell.topicLabel.text = videoThumbNailItem?.topic
        cell.topicLabel.font = UIFont(name: "Mulish", size: 15)
        cell.cellBackgroundView.backgroundColor = .clear
        cell.playButton.tintColor = subjectColorDictionary[videoThumbNailItem!.subject.capitalized]
        cell.actionToTake = {
            self.onSelectTableViewCellAction(indexPath)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! VideoItemTableViewCell
        onSelectTableViewCellAction(indexPath)
        cell.isSelected = false
    }
    func onSelectTableViewCellAction(_ indexPath: IndexPath) {
        let videoThumbNailItem = videoThumbNails?.data[indexPath.row]
        navigateToVideoController(videoThumbNailItem!.urlString)
    }
}
