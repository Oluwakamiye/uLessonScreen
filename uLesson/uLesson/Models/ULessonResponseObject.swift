//
//  Response.swift
//  uLesson
//
//  Created by Oluwakamiye Akindele on 04/03/2021.
//

import Foundation

struct ULessonResponseObject: Codable {
    var courses: Courses
    
    enum CodingKeys: String, CodingKey {
        case courses = "data"
    }
}
