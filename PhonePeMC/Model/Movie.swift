//
//  Movie.swift
//  PhonePeMC
//
//  Created by Keerthika Priya G on 07/05/22.
//

import Foundation
import UIKit


struct Results: Codable {
    var results: [Movie]?
}

class Movie:Codable {
    var original_title: String
    var popularity: Double
    var release_date: String
    var overview: String
    var poster_path: String?
    var vote_average: Double
    var image: UIImage?
    
    enum CodingKeys: String,CodingKey {
        case original_title = "original_title"
        case popularity = "popularity"
        case release_date = "release_date"
        case overview =  "overview"
        case poster_path = "poster_path"
        case vote_average = "vote_average"
    }
    
}
