//
//  TheMoviesApp.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import SwiftUI
import Combine

// Initialize and pass providers and data sources to the main app.
private let credentialsFile = Bundle.main.url(forResource: "OMDBConfigs", withExtension: "json")!
private let credentials = try! OMDBCredentials(fromFile: credentialsFile)
private let networkExecutor = NetworkExecutor(apiKey: credentials.apiKey, baseURL: credentials.baseURL)
private let movieDataSource = OMDBMoviesDataSourceNetworking(networkExecutor: networkExecutor)
private let moviesProvider = MoviesProvider(dataSource: movieDataSource)

@main
struct TheMoviesApp: App {
    @State var heck = Heck()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    print("wh")
                    heck.executeMe()
                    print("yyyy")
                }
        }
        .environment(\.moviesProvider, moviesProvider)
    }
}

@Observable
class Heck {
    var cancellable: AnyCancellable?
    
    func executeMe() {
        let credentialsFile = Bundle.main.url(forResource: "OMDBConfigs", withExtension: "json")!
        let credentials = try! OMDBCredentials(fromFile: credentialsFile)
        let networkExecutor = NetworkExecutor(apiKey: credentials.apiKey, baseURL: credentials.baseURL)
        let searchTask = SearchOMDBHTTPDataTask(searchQuery: "Spirited Away", page: 1)
        let movieTask = MovieInfoOMDBHTTPDataTask(id: "tt27003039")
        
        cancellable = networkExecutor.execute(movieTask).sink(receiveCompletion: { completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                print("We got an error")
                print(error)
            }
        }) { result in
            print("Hello")
            print(result)
        }
    }
}
