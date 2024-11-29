//
//  OMDBSearchDataSourceNetworking.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Combine

class OMDBMoviesDataSourceNetworking: OMDBMoviesDataSource {
    let networkExecutor: NetworkExecutor
    
    init(networkExecutor: NetworkExecutor) {
        self.networkExecutor = networkExecutor
    }
    
    func search(for query: String, page: Int, type: OMDBType) -> AnyPublisher<OMDBAPISearchResults, OMDBAPIError> {
        let task = SearchOMDBHTTPDataTask(searchQuery: query, page: page, type: type)
        
        let publisher = networkExecutor
            .execute(task)
            .map(\.result)
            .eraseToAnyPublisher()
        return publisher
    }
    
    func fetchMovie(with id: String) -> AnyPublisher<OMDBMovie, OMDBAPIError> {
        let task = MovieInfoOMDBHTTPDataTask(id: id)
        
        let publisher = networkExecutor
            .execute(task)
            .map(\.result)
            .eraseToAnyPublisher()
        return publisher
    }
}
