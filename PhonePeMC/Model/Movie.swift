//
//  Movie.swift
//  PhonePeMC
//
//  Created by Keerthika Priya G on 07/05/22.
//

import Foundation


struct Results: Codable {
    var results: [Movie]?
}
struct Movie:Codable {
    var original_title: String
    var popularity: Double
    var release_date: String
    var overview: String
    var poster_path: String?
    var vote_average: Double
    
}
