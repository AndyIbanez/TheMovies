//
//  MovieDetailScreen.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/29/24.
//

import SwiftUI
import Combine

@Observable
class MovieDetailViewViewModel {
    var movie: OMDBMovie?
    var error: OMDBAPIError?
    var loading: Bool = false
    
    var movieCancellable: AnyCancellable?
    
    func fetchMovie(withId id: String, usingProvider provider: MoviesProvider) {
        loading = true
        
        movieCancellable = provider
            .dataSource
            .fetchMovie(with: id)
            .sink { result in
                self.loading  = false
                switch result {
                case .finished: break
                case .failure(let error):
                    self.error = error
                }
            } receiveValue: { movie in
                self.movie = movie
            }
    }
}

struct MovieDetailScreen: View {
    @Environment(\.moviesProvider) private var moviesProvider
    
    let searchResult: OMDBSearchResult
    
    let viewModel = MovieDetailViewViewModel()

    var body: some View {
        Group {
            if viewModel.movie == nil && viewModel.error == nil {
                ProgressView()
                    .onAppear {
                        viewModel.fetchMovie(withId: searchResult.id, usingProvider: moviesProvider)
                    }
            } else if let error = viewModel.error {
                VStack {
                    OMDBErrorView(error: error)
                    Button("Retry") {
                        viewModel.fetchMovie(withId:" searchResult.id", usingProvider: moviesProvider)
                    }
                }
            } else if let movie = viewModel.movie {
                MovieDetailViewMainBody(movie: movie, originalSearchResult: searchResult)
            }
        }
    }
}
