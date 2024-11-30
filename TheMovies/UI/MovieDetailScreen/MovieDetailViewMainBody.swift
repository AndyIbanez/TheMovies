//
//  MovieDetailViewMainBody.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/29/24.
//

import SwiftUI

struct MovieDetailViewMainBody: View {
    var movie: OMDBMovie
    
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
           }
       }
       .edgesIgnoringSafeArea(.top)
    }
    
    @ViewBuilder
    var basePhoto: some View {
        Image(systemName: "photo")
            .resizable()
            .frame(width: 150, height: 225)
            .foregroundColor(.gray)
    }
}
