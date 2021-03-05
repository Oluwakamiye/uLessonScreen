//
//  Lesson.swift
//  uLesson
//
//  Created by Oluwakamiye Akindele on 04/03/2021.
//

import Foundation

struct Lesson: Codable {
    var id: Int
    var name: String
    var icon: String
    var mediaURL: String
    var subjectID, chapterID: Int

    enum CodingKeys: String, CodingKey {
        case id, name, icon
        case mediaURL = "media_url"
        case subjectID = "subject_id"
        case chapterID = "chapter_id"
    }
}
