//
//  OMDBSearchDataSourceNetworking.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Combine

class OMDBSearchDataSourceNetworking: OMDBSearchDataSource {
    let networkExecutor: NetworkExecutor
    
    init(networkExecutor: NetworkExecutor) {
        self.networkExecutor = networkExecutor
    }
    
    func search(for query: String, page: Int, type: OMDBType) -> AnyPublisher<OMDBAPISearchResults, OMDBAPIError> {
        let task = SearchOMDBHTTPDataTask(searchQuery: query, page: page, type: type)
        
        let q = networkExecutor
            .execute(task)
            .map(\.result)
            .eraseToAnyPublisher()
        return q
    }
}
