//
//  OMDBSearchResult.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

struct OMDBSearchResult: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "imdbID"
        case title = "Title"
        case year = "Year"
        case posterURL = "Poster"
    }
    
    var id: String
    var title: String
    var year: Int?
    var posterURL: String?
    
    init(id: String, title: String, year: Int, posterURL: String? = nil) {
        self.id = id
        self.title = title
        self.year = year
        self.posterURL = posterURL
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.year = Int(try container.decode(String.self, forKey: .year))
        self.posterURL = try container.decodeIfPresent(String.self, forKey: .posterURL)
    }
}
