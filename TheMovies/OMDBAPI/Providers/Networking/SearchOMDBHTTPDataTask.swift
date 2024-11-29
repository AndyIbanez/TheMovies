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
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        return request
    }
    
    func parseResponse(data: Data) throws(OMDBAPIError) -> OMDBAPISearchResultsDecodable {
        try defaultJSONDecoding(data: data)
    }
}
