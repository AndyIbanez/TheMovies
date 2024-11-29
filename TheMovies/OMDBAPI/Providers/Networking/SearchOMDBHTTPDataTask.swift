//
//  SearchOMDBHTTPDataTask.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Foundation

struct SearchOMDBHTTPDataTask: OMDBHTTPDataTask {
    typealias ResponseType = OMDBAPISearchResultsDecodable
    
    let searchQuery: String
    let page: Int?
    let type: OMDBType
    
    init(searchQuery: String, page: Int?, type: OMDBType = .movie) {
        self.searchQuery = searchQuery
        self.page = page
        self.type = type
    }
    
    func buildHTTPRequest(baseURL: URL) -> URLRequest {
        var query = [
            "type": type.rawValue,
            "s": searchQuery,
            "page": String(page ?? 1)
        ]
        .map { URLQueryItem(name: $0, value: $1) }
        
        let requestUrl = baseURL.appending(queryItems: query)
        let request = URLRequest(url: requestUrl)
        
        return request
    }
    
    func parseResponse(data: Data) throws(OMDBAPIError) -> OMDBAPISearchResultsDecodable {
        try defaultJSONDecoding(data: data)
    }
}
