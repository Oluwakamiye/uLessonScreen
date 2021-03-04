//
//  VideoThumbNail.swift
//  uLesson
//
//  Created by Oluwakamiye Akindele on 04/03/2021.
//

import Foundation

struct VideoThumbNailList: Codable{
    var data: [VideoThumbNailItem]
}

struct VideoThumbNailItem: Codable {
    var subject, imageName, topic: String
}
