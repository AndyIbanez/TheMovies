//
//  Untitled.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Foundation

extension String {
    var urlRepresentation: URL? {
        guard let url = URL(string: self) else { return nil }
        return url
    }
    
    var boolValue: Bool {
        return self == "True"
    }
}
