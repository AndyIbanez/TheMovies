//
//  NetworkExecutor.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Foundation
import Combine

class NetworkExecutor {
    let apiKey: String
    let baseURL: URL
    
    init(apiKey: String, baseURL: URL) {
        self.apiKey = apiKey
        self.baseURL = baseURL
    }
    
    func execute<T>(_ request: T) -> AnyPublisher<T.ResponseType, OMDBAPIError> where T: OMDBHTTPDataTask  {
        fatalError()
    }
    
    private func buildHTTPRequest<T>(_ request: T) throws(OMDBAPIError) -> URLRequest where T: OMDBHTTPDataTask {
        var existingRequest = request.buildHTTPRequest(baseURL: baseURL)
        guard var requestUrl = existingRequest.url else { throw OMDBAPIError.invalidURL }
        let fullURL = requestUrl.appending(queryItems: [URLQueryItem(name: "apikey", value: apiKey)])
        existingRequest.url = fullURL
        return existingRequest
    }
}
