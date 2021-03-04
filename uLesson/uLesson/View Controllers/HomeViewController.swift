//
//  ViewController.swift
//  uLesson
//
//  Created by Oluwakamiye Akindele on 04/03/2021.
//

import UIKit

class HomeViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var response : ULessonResponseObject?
    var videoThumbNails: VideoThumbNailList?
    
    var numberOfDisplayedVideos: Int = 0
    var isShowingAllVideos: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        tableView.reloadData()
        collectionView.reloadData()
    }
    
    func setNumberOfDisplayedVideos(){
        if let videoThumbNails = self.videoThumbNails{
            if isShowingAllVideos{
                numberOfDisplayedVideos = videoThumbNails.data.count
            } else {
                //TODO:- LIST OF VIDEOS
                
                numberOfDisplayedVideos = 2
            }
        } else {
            numberOfDisplayedVideos = 0
        }
        isShowingAllVideos.toggle()
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
            
            
//            UIImageView(image: UIImage(named: videoThumbNailItem?.imageName ?? "video_thumbnail_4"))
        cell.subjectLabel.text = videoThumbNailItem?.subject
        cell.topicLabel.text = videoThumbNailItem?.topic
        return cell
    }
}




// MARK:- CollectionView Implementation
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
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
        
        cell.cellLabel.text = currentSubject!.name
//        cell.cellLabel.textColor = UIColor.white
        cell.cellbackground.layer.cornerRadius = 13
        cell.cellbackground.backgroundColor = UIColor(named: "CustomBlue")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameWidth = collectionView.frame.width / 2
        return CGSize(width: frameWidth - 7, height: 50)
    }
    
    
    
    
}
