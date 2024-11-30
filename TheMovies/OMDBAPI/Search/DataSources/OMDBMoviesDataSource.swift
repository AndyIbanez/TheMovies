//
//  OMDBSearchDataSource.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Combine

protocol OMDBMoviesDataSource {
    func search(for query: String, page: Int, type: OMDBType) -> AnyPublisher<OMDBAPISearchResults, OMDBAPIError>
    func fetchMovie(with id: String) -> AnyPublisher<OMDBMovie, OMDBAPIError>
}

public class OMDBMoviesDataSourceError: OMDBMoviesDataSource {
    func search(for query: String, page: Int, type: OMDBType) -> AnyPublisher<OMDBAPISearchResults, OMDBAPIError> {
        fatalError("Please use a different Data Source")
    }
    
    func fetchMovie(with id: String) -> AnyPublisher<OMDBMovie, OMDBAPIError> {
        fatalError("Please use a different Data Source")
    }
}
