//
//  Chapter.swift
//  uLesson
//
//  Created by Oluwakamiye Akindele on 04/03/2021.
//

import Foundation

struct Chapter: Codable {
    var id: Int
    var name: String
    var lessons: [Lesson]
}
