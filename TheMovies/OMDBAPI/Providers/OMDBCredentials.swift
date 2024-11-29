//
//  OMDBCredentials.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Foundation

struct OMDBCredentials: Decodable {
    let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    init(fromFile: URL) throws {
        guard FileManager.default.fileExists(atPath: fromFile.path) else {
            throw OMDBAPIErrors.missingCredentialsFile
        }
        
        do {
            let jsonDecoder = JSONDecoder()
            let data = try Data(contentsOf: fromFile)
            let credentials = try jsonDecoder.decode(OMDBCredentials.self, from: data)
            self.apiKey = credentials.apiKey
        } catch {
            throw OMDBAPIErrors.invalidCredentialsFile
        }
    }
}
