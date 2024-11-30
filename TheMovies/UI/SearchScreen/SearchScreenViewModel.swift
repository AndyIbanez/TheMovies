//
//  SearchScreenViewModel.swift
//  TheMovies
//
//  Created by Andy Ibanez on 11/29/24.
//


import SwiftUI
import Combine

@Observable
class SearchScreenViewModel {
    var apiError: OMDBAPIError?
    var loading: Bool = false
    var searchResults: [OMDBSearchResult] = []
    var availableResults: Int = 0
    var searchQuery: String = ""
    var currentPage: Int = 1
    
    private let debounceTime: RunLoop.SchedulerTimeType.Stride = .milliseconds(300)
    
    private var searchCancellable: AnyCancellable?
    private var debounceTimer: Timer?
    
    private func performSearch(withProvider provider: MoviesProvider) {
        searchCancellable?.cancel()
        loading = true
        apiError = nil
        
        searchCancellable = provider
            .dataSource
            .search(for: searchQuery, page: currentPage, type: .movie)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.loading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.apiError = error
                }
            }, receiveValue: { results in
                self.searchResults += results.results
                self.availableResults = results.totalResults
            }
        )
    }
    
    func search(withProvider provider: MoviesProvider) {
        debounceTimer?.invalidate()

        debounceTimer = Timer.scheduledTimer(withTimeInterval: debounceTime.timeInterval, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            self.performSearch(withProvider: provider)
        }
    }
}