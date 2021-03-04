//
//  Subject.swift
//  uLesson
//
//  Created by Oluwakamiye Akindele on 04/03/2021.
//

import Foundation

struct Subject: Codable {
    var id: Int
    var name: String
    var icon: String
    var chapters: [Chapter]
}
