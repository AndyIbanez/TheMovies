//
//  NetworkExecutor.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Foundation
import Combine

class NetworkExecutor {
    typealias OMDBHTTPDataResponse<T: OMDBHTTPDataTask> = (result: T.ResponseType, response: HTTPURLResponse?)
    
    let apiKey: String
    let baseURL: URL
    let urlSession: URLSession
    
    init(apiKey: String, baseURL: URL, urlSession: URLSession = .shared) {
        self.apiKey = apiKey
        self.baseURL = baseURL
        self.urlSession = urlSession
    }
    
    func execute<T>(_ request: T) -> AnyPublisher<OMDBHTTPDataResponse<T>, OMDBAPIError> where T: OMDBHTTPDataTask  {
        do {
            let httpTask = try buildHTTPRequest(request)
            let publisher: AnyPublisher<OMDBHTTPDataResponse<T>, OMDBAPIError> =
                urlSession
                    .dataTaskPublisher(for: httpTask)
                    .tryMap {
                        let object = try request.parseResponse(data: $0)
                        let response = $1 as? HTTPURLResponse
                        return OMDBHTTPDataResponse<T>(object, response)
                    }
                    .mapError { error -> OMDBAPIError in
                        if let _ = error as? URLError {
                            return OMDBAPIError.invalidURL
                        } else if let omdbError = error as? OMDBAPIError {
                            return omdbError
                        } else {
                            return OMDBAPIError.unkwnownError
                        }
                    }
                    .eraseToAnyPublisher()
            return publisher
        } catch {
            let publisher = Fail<OMDBHTTPDataResponse<T>, OMDBAPIError>(error: error).eraseToAnyPublisher()
            return publisher
        }
    }
    
    private func buildHTTPRequest<T>(_ request: T) throws(OMDBAPIError) -> URLRequest where T: OMDBHTTPDataTask {
        var existingRequest = request.buildHTTPRequest(baseURL: baseURL)
        guard let requestUrl = existingRequest.url else { throw OMDBAPIError.invalidURL }
        let fullURL = requestUrl.appending(queryItems: [URLQueryItem(name: "apikey", value: apiKey)])
        existingRequest.url = fullURL
        return existingRequest
    }
}
