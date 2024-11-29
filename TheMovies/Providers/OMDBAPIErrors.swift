//
//  OMDBAPIErrors.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Foundation

enum OMDBAPIErrors: Error {
    case invalidCredentialsFile
    case missingCredentialsFile
    case invalidResponse
    case invalidData
}
