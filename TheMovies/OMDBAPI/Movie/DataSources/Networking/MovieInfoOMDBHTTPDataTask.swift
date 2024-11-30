//
//  MovieInfoOMDBHTTPDataTask.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Foundation

struct MovieInfoOMDBHTTPDataTask: OMDBHTTPDataTask {
    typealias ResponseType = OMDBMovie
    
    let id: String
    
    func buildHTTPRequest(baseURL: URL) -> URLRequest {
        let query = [
            "i": id
        ]
        .map { URLQueryItem(name: $0, value: $1) }
        let url = baseURL.appending(queryItems: query)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    func parseResponse(data: Data) throws -> OMDBMovie {
        return try defaultJSONDecoding(data: data)
    }
}
