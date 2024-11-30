//
//  OMDBRating.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Foundation

struct OMDBRating: Decodable & Hashable & Equatable {
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
    
    let source: String
    let value: String
    
    init(source: String, value: String) {
        self.source = source
        self.value = value
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.source = try container.decode(String.self, forKey: .source)
        self.value = try container.decode(String.self, forKey: .value)
    }
}
