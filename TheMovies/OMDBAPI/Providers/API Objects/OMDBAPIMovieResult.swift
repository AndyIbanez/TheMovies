//
//  OMDBAPIMovieResult.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Foundation

struct OMDBAPIMovieResult: Decodable {
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case posterURL = "Poster"
        case ratings = "Ratings"
    }
    
    let title: String
    let year: Int?
    let imdbID: String
    let posterURL: String?
    let ratings: [OMDBRating]
    
    init(title: String, year: Int, imdbID: String, posterURL: String?, ratings: [OMDBRating]) {
        self.title = title
        self.year = year
        self.imdbID = imdbID
        self.posterURL = posterURL
        self.ratings = ratings
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.year = Int(try container.decode(String.self, forKey: .year))
        self.imdbID = try container.decode(String.self, forKey: .imdbID)
        self.posterURL = try container.decodeIfPresent(String.self, forKey: .posterURL)
        self.ratings = try container.decode([OMDBRating].self, forKey: .ratings)
    }
}
