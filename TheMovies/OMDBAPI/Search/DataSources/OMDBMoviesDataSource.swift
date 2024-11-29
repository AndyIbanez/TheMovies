//
//  OMDBSearchDataSource.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Combine

protocol OMDBMoviesDataSource {
    func search(for query: String, page: Int, type: OMDBType) -> AnyPublisher<OMDBAPISearchResults, OMDBAPIError>
    func fetchMovie(with id: String) -> AnyPublisher<OMDBAPIMovie, OMDBAPIError>
}

public class OMDBMoviesDataSourceEmpty: OMDBMoviesDataSource {
    func search(for query: String, page: Int, type: OMDBType) -> AnyPublisher<OMDBAPISearchResults, OMDBAPIError> {
        Empty().eraseToAnyPublisher()
    }
    
    func fetchMovie(with id: String) -> AnyPublisher<OMDBAPIMovie, OMDBAPIError> {
        fatalError()
    }
}
