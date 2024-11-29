//
//  MoviesProvider.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

class MoviesProvider {
    let searchDataSource: any OMDBSearchDataSource
    let movieDataSource: any OMDBMovieDataSource
    
    init(searchDataSource: any OMDBSearchDataSource, movieDataSource: any OMDBMovieDataSource) {
        self.searchDataSource = searchDataSource
        self.movieDataSource = movieDataSource
    }
}
