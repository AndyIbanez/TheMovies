//
//  OMDBAPIError.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Foundation

enum OMDBAPIError: Error {
    case invalidCredentialsFile
    case missingCredentialsFile
    case invalidResponse
    case invalidData
    case invalidURL
    case unknownError
    case apiError(errorDescription: String)
}
