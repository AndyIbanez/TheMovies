//
//  OMDBEnvironment.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/29/24.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var moviesProvider: MoviesProvider = MoviesProvider(dataSource: OMDBMoviesDataSourceError())
}
