//
//  Award.swift
//  Aminote
//
//  Created by amin nazemzadeh on 11/28/24.
//

import Foundation

struct Award: Decodable, Identifiable {
    var id: String { name }
    var name: String
    var description: String
    var color: String
    var criterion: String
    var value: Int
    var image: String

    static let allAwards: [Award] = Bundle.main.decode("Awards.json")
    static let example = allAwards[0]
}
