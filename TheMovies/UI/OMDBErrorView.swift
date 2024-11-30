//
//  OMDBErrorView.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/29/24.
//

import SwiftUI

struct OMDBErrorView: View {
    let error: OMDBAPIError

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: errorSymbol)
                .font(.system(size: 64))
                .foregroundColor(.black)

            Text(errorTitle)
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)

            Text(errorDescription)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
    }

    private var errorSymbol: String {
        switch error {
        case .invalidCredentialsFile: return "key.slash"
        case .missingCredentialsFile: return "questionmark.folder"
        case .invalidResponse: return "exclamationmark.triangle"
        case .invalidData: return "xmark.circle"
        case .invalidURL: return "link"
        case .unknownError: return "questionmark.circle"
        case .apiError: return "circle.slash"
        }
    }

    private var errorTitle: String {
        switch error {
        case .invalidCredentialsFile: return "Invalid Credentials File"
        case .missingCredentialsFile: return "Missing Credentials File"
        case .invalidResponse: return "Invalid Response"
        case .invalidData: return "Invalid Data"
        case .invalidURL: return "Invalid URL"
        case .unknownError: return "Unknown Error"
        case .apiError: return "Error"
        }
    }

    private var errorDescription: String {
        switch error {
        case .invalidCredentialsFile:
            return "The credentials file provided is not valid. Please verify its contents."
        case .missingCredentialsFile:
            return "The credentials file is missing. Ensure it exists and is accessible."
        case .invalidResponse:
            return "The response from the server was not valid. Try again later."
        case .invalidData:
            return "The data received is not valid or corrupted."
        case .invalidURL:
            return "The URL used is invalid. Check the API endpoint."
        case .unknownError:
            return "An unknown error occurred. Please try again."
        case .apiError(let errorDescription):
            return errorDescription
        }
    }
}

struct OMDBErrorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OMDBErrorView(error: .invalidCredentialsFile)
            OMDBErrorView(error: .apiError(errorDescription: "API limit exceeded. Please try again later."))
        }
        .previewLayout(.sizeThatFits)
    }
}
