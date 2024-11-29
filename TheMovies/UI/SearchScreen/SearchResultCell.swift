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

            AsyncImage(url: URL(string: result.posterURL ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 80, height: 120)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 120)
                        .clipped()
                        .cornerRadius(8)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 120)
                        .foregroundColor(.gray)
                        .cornerRadius(8)
                @unknown default:
                    EmptyView()
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
