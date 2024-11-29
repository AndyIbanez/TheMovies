//
//  OMDBSearchDataSource.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Combine

protocol OMDBSearchDataSource {
    func search(for query: String, page: Int, type: OMDBType) -> AnyPublisher<OMDBAPISearchResults, OMDBAPIError>
}
