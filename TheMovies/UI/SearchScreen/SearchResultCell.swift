//
//  OMDBSearchResultCell.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/29/24.
//

import SwiftUI

struct SearchResultCell: View {
    let result: OMDBSearchResult

    var body: some View {
        HStack(alignment: .top, spacing: 12) {

            CachedImageView(url: URL(string: result.posterURL ?? ""))
                .frame(width: 80, height: 120)
                .cornerRadius(8)
                .background {
                    if result.posterURL != nil {
                        ProgressView()
                    } else {
                        Image(systemName:"photo")
                    }
                }


            VStack(alignment: .leading, spacing: 4) {
                Text(result.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)

                if let year = result.year {
                    Text("Year: \(year)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()
        }
        .padding(.vertical, 8)
    }
}
