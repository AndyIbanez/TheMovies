//
//  OMDBAPIResult.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Foundation

struct OMDBBaseResult: Decodable {
    enum CodingKeys: String, CodingKey {
        case success = "Response"
        case error = "Error"
    }
    
    let success: Bool
    let error: String?
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decode(String.self, forKey: .success).boolValue
        self.error = try container.decodeIfPresent(String.self, forKey: .error)
    }
}


