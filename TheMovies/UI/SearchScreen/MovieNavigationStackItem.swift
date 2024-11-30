//
//  MovieNavigationStack.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/29/24.
//


import SwiftUI
import Combine

enum MovieNavigationStackItem: Hashable {
    case movie(searchResult: OMDBSearchResult)
    case favoriteMovies
}
