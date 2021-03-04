//
//  Response.swift
//  uLesson
//
//  Created by Oluwakamiye Akindele on 04/03/2021.
//

import Foundation

struct Response: Codable {
    var status, message: String
    var subjects: [Subject]
}
