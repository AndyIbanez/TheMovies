//
//  OMDBAPISearchResultsProtocol.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Foundation

protocol OMDBAPISearchResultsProtocol {
    var results: [OMDBSearchResult] { get }
    var totalResults: Int { get }
}
