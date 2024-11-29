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
    
    private let debounceTime: RunLoop.SchedulerTimeType.Stride = .milliseconds(300)
    
    private var cancellables: Set<AnyCancellable> = []
    
    func search(for query: String, page: Int, withProvider provider: MoviesProvider) {
        loading = true
        apiError = nil
        
        provider
            .dataSource
            .search(for: query, page: page, type: .movie)
            //.debounce(for: debounceTime, scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.loading = false
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
    
    @State private var viewModel = SearchScreenViewModel()
    @State private var navigationStack: [MovieNavigationStack] = []
    @State private var searchText: String = ""
    @State private var currentPage: Int = 1
    
    var body: some View {
        NavigationStack(path: $navigationStack) {
            Group {
                if viewModel.loading {
                    ProgressView()
                } else if let error = viewModel.apiError {
                    OMDBErrorView(error: error)
                } else if searchText.isEmpty {
                    startSearchingView
                } else if !viewModel.loading && !searchText.isEmpty && viewModel.searchResults.isEmpty {
                    ContentUnavailableView.search(text: searchText)
                } else {
                    List(viewModel.searchResults) { result in
                        Text(result.title)
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $searchText, prompt: "Movie title")
            .onChange(of: searchText) { oldValue, newValue in
                currentPage = 1
                viewModel.searchResults.removeAll()
                if newValue.count > 3 {
                    viewModel.search(for: newValue, page: currentPage, withProvider: moviesProvider)
                }
            }
        }
    }
    
    @ViewBuilder
    private var startSearchingView: some View {
        VStack {
            VStack(spacing: 16) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 64))
                    .foregroundColor(.black)

                Text("Search")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)

                Text("Use the search bar to find a movie")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
            }
            .padding()
        }
    }
}

enum MovieNavigationStack: Hashable {
    case movie(OMDBMovie)
}

#Preview {
    SearchScreen()
}
