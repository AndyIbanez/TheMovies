//
//  SearchResultGridItem.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/29/24.
//


import SwiftUI
import SwiftData

struct SearchResultGridItem: View {
    let result: OMDBSearchResult

    var body: some View {
        ZStack(alignment: .bottom) {
            CachedImageView(url: URL(string: result.posterURL ?? ""))
                .scaledToFill()
                .frame(height: 250)
                .clipped()

            HStack(alignment: .top, spacing: 4) {
                VStack {
                    HStack {
                        Text(result.title)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    
                    if let year = result.year {
                        HStack {
                            Text("\(year)")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(0.7))
        }
        .frame(height: 250)
        .cornerRadius(12)
    }
}
