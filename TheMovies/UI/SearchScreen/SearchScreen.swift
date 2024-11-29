//
//  SearchScreen.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/29/24.
//

import SwiftUI
import Combine

@Observable
class SearchScreenViewModel {
    var apiError: OMDBAPIError?
    var loading: Bool = false
    var searchResults: [OMDBSearchResult] = []
    var availableResults: Int = 0
    
    private var cancellables: Set<AnyCancellable> = []
    
    func search(for query: String, page: Int, withProvider provider: MoviesProvider) {
        loading = true
        apiError = nil
        
        provider
            .dataSource
            .search(for: query, page: page, type: .movie)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.apiError = error
                }
            }, receiveValue: { results in
                self.searchResults += results.results
                self.availableResults = results.totalResults
            }
        )
        .store(in: &cancellables)
    }
}

struct SearchScreen: View {
    @Environment(\.moviesProvider) private var moviesProvider
    
    @State private var navigationStack: [MovieNavigationStack] = []
    @State private var searchText: String = ""
    @State private var currentPage: Int = 1
    
    var body: some View {
        NavigationStack(path: $navigationStack) {
            List {
                Text("Sup")
            }
            .navigationTitle("Search")
            .searchable(text: $searchText, prompt: "Movie title")
        }
    }
}

enum MovieNavigationStack: Hashable {
    case movie(OMDBMovie)
}

#Preview {
    SearchScreen()
}
