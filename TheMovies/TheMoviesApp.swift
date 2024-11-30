//
//  TheMoviesApp.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import SwiftUI
import Combine
import SwiftData

// Initialize and pass providers and data sources to the main app.
private let credentialsFile = Bundle.main.url(forResource: "OMDBConfigs", withExtension: "json")!
private let credentials = try! OMDBCredentials(fromFile: credentialsFile)
private let networkExecutor = NetworkExecutor(apiKey: credentials.apiKey, baseURL: credentials.baseURL)
private let movieDataSource = OMDBMoviesDataSourceNetworking(networkExecutor: networkExecutor)
private let moviesProvider = MoviesProvider(dataSource: movieDataSource)

@main
struct TheMoviesApp: App {
    var body: some Scene {
        WindowGroup {
            SearchScreen()
        }
        .environment(\.moviesProvider, moviesProvider)
        .modelContainer(for: [OMDBSearchResult.self])
    }
}
