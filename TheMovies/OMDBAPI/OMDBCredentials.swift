//
//  OMDBCredentials.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import Foundation

struct OMDBCredentials: Decodable {
    let apiKey: String
    let baseURL: URL
    
    init(apiKey: String, baseURL: URL) {
        self.apiKey = apiKey
        self.baseURL = baseURL
    }
    
    init(fromFile: URL) throws {
        guard FileManager.default.fileExists(atPath: fromFile.path) else {
            throw OMDBAPIError.missingCredentialsFile
        }
        
        do {
            let jsonDecoder = JSONDecoder()
            let data = try Data(contentsOf: fromFile)
            let credentials = try jsonDecoder.decode(OMDBCredentials.self, from: data)
            self = credentials
        } catch {
            throw OMDBAPIError.invalidCredentialsFile
        }
    }
}
