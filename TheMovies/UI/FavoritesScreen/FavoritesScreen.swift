//
//  FavoritesScreen.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/29/24.
//

import SwiftUI
import SwiftData

struct FavoritesScreen: View {
    @Query private var searchResults: [OMDBSearchResult]
    @Binding var navigationPath: [MovieNavigationStackItem]
    
    var body: some View {
        SearchResultGridView(results: searchResults, navigationPath: $navigationPath)
    }
}
