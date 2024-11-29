//
//  OMDBSearchResultsDecodable.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Foundation

struct OMDBAPISearchResultsDecodable : Decodable & OMDBAPISearchResultsProtocol {
    enum CodingKeys: String, CodingKey {
        case results = "Search"
        case totalResults
        case success = "Response"
        case error = "Error"
    }
    
    var results: [OMDBSearchResult]
    var totalResults: Int
    var success: Bool
    var error: String?
    
    init(results: [OMDBSearchResult], totalResults: Int, response: Bool, error: String? = nil) {
        self.results = results
        self.totalResults = totalResults
        self.success = response
        self.error = error
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decode([OMDBSearchResult].self, forKey: .results)
        self.totalResults = Int(try container.decode(String.self, forKey: .totalResults)) ?? 0
        self.success = try container.decode(String.self, forKey: .success).boolValue
        self.error = try container.decodeIfPresent(String.self, forKey: .error)
    }
}
