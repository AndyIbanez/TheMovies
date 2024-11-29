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
    var searchQuery: String = ""
    var currentPage: Int = 1
    
    private let debounceTime: RunLoop.SchedulerTimeType.Stride = .milliseconds(300)
    
    private var searchCancellable: AnyCancellable?
    
    func search(withProvider provider: MoviesProvider) {
        //searchCancellable?.cancel()
        loading = true
        apiError = nil
        
        searchCancellable = provider
            .dataSource
            .search(for: searchQuery, page: currentPage, type: .movie)
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
    }
}

struct SearchScreen: View {
    @Environment(\.moviesProvider) private var moviesProvider
    
    @State private var viewModel = SearchScreenViewModel()
    @State private var navigationStack: [MovieNavigationStack] = []
    
    var body: some View {
        NavigationStack(path: $navigationStack) {
            Group {
                if viewModel.loading {
                    ProgressView()
                } else if errorIsNoMovieFound(error: viewModel.apiError) {
                    ContentUnavailableView.search(text: viewModel.searchQuery)
                } else if let error = viewModel.apiError {
                    OMDBErrorView(error: error)
                } else if viewModel.searchQuery.isEmpty {
                    startSearchingView
                } else if !viewModel.loading && !viewModel.searchQuery.isEmpty && viewModel.searchResults.isEmpty {
                    ContentUnavailableView.search(text: viewModel.searchQuery)
                } else {
                    List(viewModel.searchResults) { result in
                        Text(result.title)
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $viewModel.searchQuery, prompt: "Movie title")
            .onChange(of: viewModel.searchQuery) { oldValue, newValue in
                viewModel.currentPage = 1
                viewModel.searchResults.removeAll()
                if newValue.count > 3 {
                    viewModel.search(withProvider: moviesProvider)
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
    
    func errorIsNoMovieFound(error: OMDBAPIError?) -> Bool {
        guard let error else { return false }
        switch error {
        case .apiError(let errorDescription):
            return errorDescription.localizedCaseInsensitiveContains("movie not found")
        default: return false
        }
    }
}

enum MovieNavigationStack: Hashable {
    case movie(OMDBMovie)
}

#Preview {
    SearchScreen()
}
