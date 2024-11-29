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
    @State var fuck = Fuck()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    print("wh")
                    fuck.executeMe()
                    print("yyyy")
                }
        }
    }
}

@Observable
class Fuck {
    var cancellable: AnyCancellable?
    
    func executeMe() {
        let credentialsFile = Bundle.main.url(forResource: "OMDBConfigs", withExtension: "json")!
        let credentials = try! OMDBCredentials(fromFile: credentialsFile)
        let networkExecutor = NetworkExecutor(apiKey: credentials.apiKey, baseURL: credentials.baseURL)
        let searchTask = SearchOMDBHTTPDataTask(searchQuery: "Spirited Away", page: 1)
        
        cancellable = networkExecutor.execute(searchTask).sink(receiveCompletion: { completion in
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
