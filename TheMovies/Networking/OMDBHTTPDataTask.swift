//
//  OMDBHTTPDataTask.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Foundation

public protocol OMDBHTTPDataTask {
    associatedtype ResponseType
    
    func buildHTTPRequest() -> URLRequest
    func parseResponse(data: Data) throws -> ResponseType
}
