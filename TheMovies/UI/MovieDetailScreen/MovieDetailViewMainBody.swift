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
                       AsyncImage(url: url) { phase in
                           switch phase {
                           case .empty:
                               Color.gray
                           case .success(let image):
                               image
                                   .resizable()
                                   .aspectRatio(contentMode: .fill)
                                   .blur(radius: 20)
                           case .failure:
                               Color.gray
                           @unknown default:
                               EmptyView()
                           }
                       }
                   } else {
                       Color.gray
                   }
               }
               .frame(height: 250)
               .clipped()
               .overlay(
                   VStack {
                       if let posterURL = movie.posterURL, let url = URL(string: posterURL) {
                           AsyncImage(url: url) { phase in
                               switch phase {
                               case .empty:
                                   ProgressView()
                               case .success(let image):
                                   image
                                       .resizable()
                                       .aspectRatio(contentMode: .fit)
                                       .frame(width: 150)
                                       .shadow(radius: 10)
                               case .failure:
                                   Image(systemName: "photo")
                                       .resizable()
                                       .frame(width: 150, height: 225)
                                       .foregroundColor(.gray)
                               @unknown default:
                                   EmptyView()
                               }
                           }
                       } else {
                           Image(systemName: "photo")
                               .resizable()
                               .frame(width: 150, height: 225)
                               .foregroundColor(.gray)
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
}
