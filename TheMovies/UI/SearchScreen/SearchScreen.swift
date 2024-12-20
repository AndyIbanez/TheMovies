//
//  SearchScreen.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/29/24.
//

import SwiftUI
import Combine

struct SearchScreen: View {
    @Environment(\.moviesProvider) private var moviesProvider
    
    @State private var viewModel = SearchScreenViewModel()
    @State private var navigationStack: [MovieNavigationStackItem] = []
    
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
                        SearchResultCell(result: result)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                let movie = MovieNavigationStackItem.movie(searchResult: result)
                                navigationStack.append(movie)
                            }
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
            .navigationDestination(for: MovieNavigationStackItem.self) { item in
                switch item {
                case .movie(let movie):
                    MovieDetailScreen(searchResult: movie)
                case .favoriteMovies: FavoritesScreen(navigationPath: $navigationStack)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Favorites") {
                        let faves = MovieNavigationStackItem.favoriteMovies
                        navigationStack.append(faves)
                    }
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

#Preview {
    SearchScreen()
}
