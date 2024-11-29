//
//  SearchOMDBHTTPDataTask.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Foundation

struct SearchOMDBHTTPDataTask: OMDBHTTPDataTask {
    typealias ResponseType = OMDBAPISearchResultsDecodable
    
    func buildHTTPRequest() -> URLRequest {
        fatalError()
    }
    
    func parseResponse(data: Data) throws(OMDBAPIError) -> OMDBAPISearchResultsDecodable {
        try defaultJSONDecoding(data: data)
    }
}
