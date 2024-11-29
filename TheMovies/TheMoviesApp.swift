//
//  TheMoviesApp.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

import SwiftUI
import Combine

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
