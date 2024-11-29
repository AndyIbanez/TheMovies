//
//  OMDBAPIResultsProtocol.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Foundation

struct OMDBBaseResult: Decodable {
    let success: Bool
    let error: String?
}


