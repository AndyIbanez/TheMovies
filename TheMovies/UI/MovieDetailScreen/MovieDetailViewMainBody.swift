//
//  MovieDetailViewMainBody.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/29/24.
//

import SwiftUI
import SwiftData

struct MovieDetailViewMainBody: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var searchResults: [OMDBSearchResult]
    
    var movie: OMDBMovie
    var originalSearchResult: OMDBSearchResult
    
    var body: some View {
        ScrollView {
           VStack(spacing: 16) {
               ZStack {
                   if let posterURL = movie.posterURL, let url = URL(string: posterURL) {
                       CachedImage(url: url)
                           .scaledToFill()
                           .blur(radius: 20)
                           .background(Color.gray)
                   } else {
                       Color.gray
                   }
               }
               .frame(height: 250)
               .clipped()
               .overlay(
                   VStack {
                       if let posterURL = movie.posterURL, let url = URL(string: posterURL) {
                           CachedImage(url: url)
                               .frame(width: 150, height: 225)
                               .shadow(radius: 10)
                               .background {
                                   basePhoto
                                       .clipped()
                               }
                       } else {
                           basePhoto
                       }
                   }
                   .offset(y: 100)
               )
               .padding(.bottom, 100)
               

               VStack(alignment: .leading, spacing: 16) {
                   VStack(alignment: .center, spacing: 8) {
                       Text(movie.title)
                           .font(.title)
                           .fontWeight(.bold)
                           .multilineTextAlignment(.center)

                       if let year = movie.year {
                           Text("Year: \(year)")
                               .font(.subheadline)
                               .foregroundColor(.secondary)
                       }
                   }
                   .frame(maxWidth: .infinity)


                   if let plot = movie.plot {
                       Text(plot)
                           .font(.body)
                           .foregroundColor(.primary)
                           .multilineTextAlignment(.leading)
                   }


                   if !movie.ratings.isEmpty {
                       VStack(alignment: .leading, spacing: 8) {
                           Text("Ratings")
                               .font(.headline)
                           
                           ForEach(movie.ratings, id: \.self) { rating in
                               HStack {
                                   Text(rating.source)
                                       .font(.subheadline)
                                       .fontWeight(.semibold)
                                   Spacer()
                                   Text(rating.value)
                                       .font(.subheadline)
                                       .foregroundColor(.secondary)
                               }
                               .padding(.vertical, 4)
                           }
                       }
                   }
               }
               .padding(.horizontal)
               
               Button(action: {
                   withAnimation {
                       if let searchResult {
                           modelContext.delete(searchResult)
                       } else {
                           modelContext.insert(originalSearchResult)
                       }
                   }
               }) {
                   if isFavorited {
                       Label("Remove from favorites", systemImage: "star.slash")
                           .foregroundColor(.red)
                   } else {
                       Label("Add to favorites", systemImage: "star")
                           .foregroundStyle(.blue)
                   }
               }
               .buttonStyle(.bordered)
           }
       }
       .edgesIgnoringSafeArea(.top)
    }
    
    private var isFavorited: Bool {
        return searchResult == nil
    }
    
    private var searchResult: OMDBSearchResult? {
        return searchResults.first { $0.id == movie.imdbID }
    }
    
    @ViewBuilder
    var basePhoto: some View {
        Image(systemName: "photo")
            .resizable()
            .frame(width: 150, height: 225)
            .foregroundColor(.gray)
    }
}
