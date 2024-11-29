//
//  OMDBAPIResultsProtocol.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Foundation

protocol OMDBBaseResultProtocol {
    var success: Bool { get }
    var error: String? { get }
}
