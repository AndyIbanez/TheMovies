//
//  OMDBAPIResultsProtocol.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Foundation

protocol OMDBAPIResultsProtocol {
    var success: Bool { get }
    var error: String? { get }
}
