//
//  OMDBHTTPDataTask+Extensions.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//
import Foundation

extension OMDBHTTPDataTask where ResponseType: Decodable {
    func defaultJSONDecoding(data: Data) throws(OMDBAPIError) -> ResponseType {
        let jsonDecoder = JSONDecoder()
        do {
            return try jsonDecoder.decode(ResponseType.self, from: data)
        } catch {
            throw OMDBAPIError.invalidResponse
        }
    }
}

extension OMDBHTTPDataTask {
    
}
