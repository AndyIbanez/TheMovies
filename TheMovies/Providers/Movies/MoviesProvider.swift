//
//  MoviesProvider.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/28/24.
//

class MoviesProvider {
    let dataSource: any OMDBMoviesDataSource
    
    init(dataSource: any OMDBMoviesDataSource) {
        self.dataSource = dataSource
    }
}
