//
//  SearchScreen.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/29/24.
//

import SwiftUI

@Observable
class SearchScreenViewModel {
    var apiError: OMDBAPIError?
    var loading: Bool = false
}

struct SearchScreen: View {
    @State private var navigationStack: [MovieNavigationStack] = []
    
    var body: some View {
        NavigationStack(path: $navigationStack) {
            List {
                Text("Sup")
            }
            .navigationTitle("Search")
        }
    }
}

enum MovieNavigationStack: Hashable {
    case movie(OMDBMovie)
}

#Preview {
    SearchScreen()
}
