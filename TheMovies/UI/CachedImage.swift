import SwiftUI

struct CachedImage: View {
    let url: URL?
    let scale: CGFloat
    let transaction: Transaction
    let cache: URLCache
    let session: URLSession

    @State private var image: UIImage?
    @State private var isLoading: Bool = false

    init(
        url: URL?,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        cache: URLCache = URLCache.shared,
        session: URLSession = URLSession.shared
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.cache = cache
        self.session = session
    }

    var body: some View {
        ZStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .animation(transaction.animation, value: image) // Animate when the image changes
            } else if isLoading {
                ProgressView()
            } else {
                Color.gray
            }
        }
        .onAppear(perform: loadImage)
    }

    private func loadImage() {
        guard let url = url else { return }

        let request = URLRequest(url: url)
        
        // Check cache for the image
        if let cachedResponse = cache.cachedResponse(for: request),
           let cachedImage = UIImage(data: cachedResponse.data, scale: scale) {
            self.image = cachedImage
            return
        }

        // Image not in cache, download it
        isLoading = true
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
                if let data = data,
                   let response = response,
                   let downloadedImage = UIImage(data: data, scale: scale) {
                    // Cache the image
                    let cachedResponse = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedResponse, for: request)

                    // Update the UI with a transaction animation
                    withTransaction(transaction) {
                        self.image = downloadedImage
                    }
                }
            }
        }.resume()
    }
}
