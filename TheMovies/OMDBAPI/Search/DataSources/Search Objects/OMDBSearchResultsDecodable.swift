//
//  OMDBSearchResultsDecodable.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Foundation

struct OMDBAPISearchResults : Decodable & OMDBAPISearchResultsProtocol {
    enum CodingKeys: String, CodingKey {
        case totalResults
        case results = "Search"
    }
    
    var results: [OMDBSearchResult]
    var totalResults: Int
    
    init(results: [OMDBSearchResult], totalResults: Int) {
        self.results = results
        self.totalResults = totalResults
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.totalResults = Int(try container.decode(String.self, forKey: .totalResults)) ?? 0
        self.results = try container.decode([OMDBSearchResult].self, forKey: .results)
    }
}
