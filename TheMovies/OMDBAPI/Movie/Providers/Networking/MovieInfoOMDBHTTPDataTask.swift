//
//  MovieInfoOMDBHTTPDataTask.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Foundation

struct MovieInfoOMDBHTTPDataTask: OMDBHTTPDataTask {
    typealias ResponseType = OMDBAPIMovieResult
    
    let id: String
    
    func buildHTTPRequest(baseURL: URL) -> URLRequest {
        let query = [
            "id": id
        ]
        .map { URLQueryItem(name: $0, value: $1) }
        fatalError()
    }
    
    func parseResponse(data: Data) throws -> OMDBAPIMovieResult {
        return try defaultJSONDecoding(data: data)
    }
}
