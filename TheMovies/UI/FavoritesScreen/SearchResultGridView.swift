//
//  SearchResultGridView.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/29/24.
//


import SwiftUI
import SwiftData

struct SearchResultGridView: View {
    let results: [OMDBSearchResult]
    
    @Binding var navigationPath: [MovieNavigationStackItem]
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        if results.isEmpty {
            ContentUnavailableView(
                "No Favorites",
                systemImage: "star.slash",
                description: Text("To add a favorite, search for a movie and tap \"Add to favorites\".")
            )
        } else {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(results) { result in
                        SearchResultGridItem(result: result)
                            .onTapGesture {
                                let movie = MovieNavigationStackItem.movie(searchResult: result)
                                navigationPath.append(movie)
                            }
                    }
                }
                .padding()
            }
        }
    }
}
